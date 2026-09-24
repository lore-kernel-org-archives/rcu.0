Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997D38DC68;
	Thu, 24 Sep 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249599; cv=none; b=j9vzXRnsvgSLs2EedRGCYstkmCqv6Zuy3t/5CYs6II1JzaJ3G9Bu/I5p/gSoexbnWIHk1HTLaNwmKsboSY+X87MyYpLj59uj5y152RM+3MOSna3AD+tC7p/CwP81frDFYhG/vcZQ+qj7Q/YCm6OVLt7JrkeQFPIx5TzK+ijB/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249599; c=relaxed/simple;
	bh=bi4A9oP6oNMDEiR09MQYo1/7+Q8TAO2XFMTYuwz/r3c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LEtSpcAZ5PE5gFTPn9EByIdLvbRWc8QzzXqQpqovsMEmdO5Li4ZbE+NMHG/288CWzK7G6zdmz5uB187brPJSgQQkIRg0W2Rvhg6ENNCXDclVoyvasytZCBmr8Ekyaqjf0r5jakDoSh0qVfPHn0R97FV5x4o5gv8vNJTj2TKWDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2XHoE6F; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2XHoE6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790249595; x=1821785595;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bi4A9oP6oNMDEiR09MQYo1/7+Q8TAO2XFMTYuwz/r3c=;
  b=K2XHoE6FgimUriwpllOuNFRofZ3tYJvZ04clhieswYlcpsd1zI8yDBPZ
   +elZn6SIX65RZsMapoTGjb5yjxNgNq/PLyLuQyoQ5X+qNeOTvU4SATsFm
   5Bd9Jf+7xdEdeQZTSkKTF2LJILJZXyYXhiWuUDbhUsM4b2HswXt7LmChA
   94qQs2oF831NfScdYBWjJutHA1L2+IdF6ShLok15WXsNHz+YwdWV3MFso
   STIp/BVq0PI1z++I41KmHBf7jYhZU3eM1q3Zpwn75xhv2wmDoxbcrgPWg
   iNdbySD5Bl900p3eADvZiHLIdfwhpu8qwJ00IzHSfXhO2LB8eG2NGUUbv
   w==;
X-CSE-ConnectionGUID: +Ocl9J/+TWe6YBQX0MEd3g==
X-CSE-MsgGUID: 5Yug119FS8S6uNy+c9Z1Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89877578"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89877578"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:33:13 -0700
X-CSE-ConnectionGUID: dF85Lm6WRf22zoxZNwTU5w==
X-CSE-MsgGUID: 846Iiz+NT06RMKm4RjbHsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="270487899"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:33:11 -0700
Date: Thu, 24 Sep 2026 19:33:08 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	yi1.lai@intel.com
Subject: [linus:master] [rcu]  ec5ee5417b:  stress-ng.ramfs.ops_per_sec 25.7%
 improvement
Message-ID: <202609241934.228b4a14-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a 25.7% improvement of stress-ng.ramfs.ops_per_sec on:


commit: ec5ee5417b00278fa050b38d878b76f1365420fb ("rcu: Advance callbacks for expedited GP completion in rcu_core()") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 64G memory
parameters:

  nr_threads: 100%
  testtime: 60s
  test: ramfs
  cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260924/202609241934.228b4a14-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-gnr-2sp4/ramfs/stress-ng/60s

commit: 
  fde2b18817 ("rcu: Detect expedited grace period completion in rcu_pending()")
  ec5ee5417b ("rcu: Advance callbacks for expedited GP completion in rcu_core()")

fde2b18817e4f32b ec5ee5417b00278fa050b38d878
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    427110           +25.7%     537009        stress-ng.ramfs.ops
      7124           +25.7%       8957        stress-ng.ramfs.ops_per_sec
      6004 ±  2%    +561.7%      39731        stress-ng.time.involuntary_context_switches
    685.50            -5.1%     650.33        stress-ng.time.percent_of_cpu_this_job_got
    405.23            -5.4%     383.53        stress-ng.time.system_time
    776758           +19.9%     931227        stress-ng.time.voluntary_context_switches


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

