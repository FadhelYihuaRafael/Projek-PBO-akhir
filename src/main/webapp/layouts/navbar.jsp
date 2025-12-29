<%-- 
    Document   : navbar
    Created on : 17 Dec 2025, 17.46.49
    Author     : Admin
    Description: Sidebar/Navbar component
--%>

<aside class="left-sidebar">
  <div>
    <div class="brand-logo d-flex align-items-center justify-content-between">
      <a href="dashboard.jsp" class="text-nowrap logo-img">
        <img src="../assets/images/logos/logo-light.svg" alt="" />
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
          <a class="sidebar-link" href="dashboard.jsp" aria-expanded="false">
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
          <a class="sidebar-link" href="supplier.jsp" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:truck-delivery" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Supplier</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="bahan-baku.jsp" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:package-variant" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Bahan Baku</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="kategori-menu.jsp" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:folder-multiple" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Kategori Menu</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="menu.jsp" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:food" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Menu</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="resep.jsp" aria-expanded="false">
            <span>
              <iconify-icon icon="mdi:book-open-variant" class="fs-6"></iconify-icon>
            </span>
            <span class="hide-menu">Resep</span>
          </a>
        </li>
        
        <li class="nav-small-cap">
          <iconify-icon icon="solar:menu-dots-linear" class="nav-small-cap-icon fs-6"></iconify-icon>
          <span class="hide-menu">AUTH</span>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="../login_1.jsp" aria-expanded="false">
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

