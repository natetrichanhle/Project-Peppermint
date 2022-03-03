<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <!-- for Bootstrap CSS -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <!-- YOUR own local CSS -->
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <!-- For any Bootstrap that uses JS or jQuery-->
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <!-- YOUR own local JS -->
    <script type="text/javascript" src="/js/app.js"></script>
</head>
<body>
    <!-- Enter body here -->
    <div class="navbar logo">    
        <img src="/images/peppermint.png" alt="logo" class="w-25">
    </div>
    <div class="container d-flex">
        <div class="accounts-container">
            <div class="accounts">
                <div class="d-flex justify-content-center align-items-center month-container">
                    <div>
                        <h1 class="month-head">${month.getMonthOfYear()}</h1>
                    </div>
                    <div>
                        <select name="month-dropdown">
                            <c:forEach var="m" items="${loggedInUser.getMonths()}">
                                <option>
                                    <c:out value="${m.getMonthOfYear()}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="accounts-tabs4">
                    <h3 class="total-h3">Monthly Income: $${monthlyTotal}</h3>
                </div>
                <div class="accounts-tabs">
                    <h3 class="savings-h3">Savings: $${Math.floor(month.getSavings().getTotal())}</h3>
                </div>
                <div class="accounts-tabs2">
                    <h3 class="investments-h3">Investments: $${Math.floor(month.getInvestment().getTotalInvestments())}</h3>
                </div>
                <div class="accounts-tabs3">
                    <h3 class="utilities-h3">Utilities: $${Math.floor(month.getSavings().getTotal() - month.getInvestment().getTotalInvestments())}</h3>
                </div>
            </div>
        </div>
<!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
        <div class="gi-container">
            <div class="goals">
                <div class="d-flex justify-content-center">
                    <h1 class="dash-h1 col-sm-6 col-md-8 goal-h1">Goals</h1>
                    <a href="/goals/new/" class="col-6 col-md-4">
                        <img src="/images/addbutton.png" alt="addbutton" class="addbtn goalbtn">
                    </a>
                </div>
                <div class="goal-info mx-5">
                    <table class="table table-borderless d-flex align-items-center justify-content-center">
                    <c:forEach var="goal" items="${month.getGoals()}">
                        <tr>
                            <td class="goalList">
                                <c:out value="${goal.description}"/>
                            </td>
                            <td>
                                <td>
                                    <form action="/goals/${goal.id}" method="post">
                                        <input type="hidden" name="_method" value="delete">
                                        <input type="submit" value="Delete" class="btn goal-deletebtn">
                                    </form>
                                </td>
                            </td>
                        </tr>
                    </c:forEach>
                    </table>
                </div>
            </div>
<!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
            <div class="investments">
                <div class="d-flex justify-content-center">
                    <h1 class="dash-h1 invest-h1">Investments</h1>
                    <a href="/investments/new">
                        <img src="/images/addbutton.png" alt="addbutton" class="addbtn investbtn">
                    </a>
                </div>
                <div class="mx-5 d-flex justify-content-between">
                    <!-- render some shit here for investments -->
                    <div class="d-flex align-items-center">
                        <div>
                            <h3>Roth Ira:</h3>
                            <h3>Crypto:</h3>
                            <h3>Stocks:</h3>
                        </div>
                    </div>
                    <img class="pi-chart" src="https://quickchart.io/chart?c={
                    type:'doughnut',
                    data:{
                    labels:['RothIRA','Stocks','Crypto'],
                    datasets:[{
                    data:[
                        ${month.getInvestment().getRothIraAmount()},
                        ${month.getInvestment().getStocksAmount()},
                        ${month.getInvestment().getCryptoAmount()}]}]},
                    options:{
                        plugins:{doughnutlabel:{labels:[{text:'${Math.floor(month.getInvestment().getTotalInvestments())}',color:'white',
                    font:{size:20}},{text:'total',color:'white'}]}}}}">
                </div>
            </div>
        </div>
    </div>
<!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
    <div class ="container">
        <div class="budget-container">
            <div class="d-flex justify-content-center">
                <h1 class="dash-h1 budget-h1">Savings & Expenses</h1>
                <a href="/budgets/new">
                    <img src="/images/addbutton.png" alt="addbutton" class="addbtn budgetbtn">
                </a>
            </div>
            <div class="mx-5 d-flex justify-content-evenly">
                <div class="mx-5 spend-container">
                    <p class="expense-h4">You have --- left to spend this month.</p>
                </div>
                <div class="mx-5 saving-container">
                    <table class="table table-hover budgetTable">
                        <tr>
                            <th class="budget-th">Expenses</th>
                            <th class="budget-th">Amount</th>
                            <th class="budget-th">Actions</th>
                        </tr>
                        <c:forEach var="budget" items="${month.getSavings().getExpenses()}">
                        <tr class="budgetList">
                            <td>
                                <c:out value="${budget.category}"/>
                            </td>
                            <td>
                                $<c:out value="${budget.amount}"/>
                            </td>
                            <td>
                                <form action="/budgets/${budget.id}" method="post">
                                    <input type="hidden" name="_method" value="delete">
                                    <input type="submit" value="Delete" class="btn">
                                </form>
                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>