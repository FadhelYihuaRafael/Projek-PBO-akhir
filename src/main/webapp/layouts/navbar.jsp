<%-- 
    Document   : navbar
    Created on : 17 Dec 2025, 17.46.49
    Author     : Admin
    Description: Sidebar/Navbar component
--%>
<%
    String contextPath = request.getContextPath();
    String dashboardUrl = contextPath + "/layouts/dashboard.jsp";
    String supplierUrl = contextPath + "/SupplierController";
    String bahanBakuUrl = contextPath + "/BahanBakuController";
    String kategoriMenuUrl = contextPath + "/KategoriMenuController";
    String menuUrl = contextPath + "/MenuController";
    String resepUrl = contextPath + "/ResepController";
%>
<aside class="left-sidebar">
  <div>
    <div class="brand-logo d-flex align-items-center justify-content-between">
      <a href="<%= dashboardUrl %>" class="text-nowrap logo-img">
        <img src="<%= contextPath %>/assets/images/logos/logo-light.svg" alt="" />
      </a>
      <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
        <i class="ti ti-x fs-8"></i>
      </div>
    </div>
    
    <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
      <ul id="sidebarnav">
        <li class="nav-small-cap">
          <i class="ti ti-dots nav-small-cap-icon fs-6"></i>
          <span class="hide-menu">Home</span>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="<%= dashboardUrl %>" aria-expanded="false">
            <span>
              <iconify-icon icon="solar:home-smile-bold-duotone" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Dashboard</span>
          </a>
        </li>
        
        <li class="nav-small-cap">
          <i class="ti ti-dots nav-small-cap-icon fs-6"></i>
          <span class="hide-menu">Master Data</span>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="<%= supplierUrl %>" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:truck-delivery" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Supplier</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="<%= bahanBakuUrl %>" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:package-variant" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Bahan Baku</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="<%= resepUrl %>" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:book-open-variant" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Resep</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="<%= kategoriMenuUrl %>" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:folder-multiple" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Kategori Menu</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="<%= menuUrl %>" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:food" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Menu</span>
          </a>
      </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="<%= request.getContextPath() %>/LogoutController" aria-expanded="false">
            <span>
              <iconify-icon icon="solar:login-3-bold-duotone" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Logout</span>
          </a>
        </li>
      </ul>
    </nav>
  </div>
</aside>

