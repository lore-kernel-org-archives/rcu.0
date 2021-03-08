Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1CEC433E0
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81C064FC8
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 23:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCHXpt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:45:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:13657 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhCHXpm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Mar 2021 18:45:42 -0500
IronPort-SDR: OXjJDEUwXJktBNDbmDZ9375KYelFuGPuOYq64J5w/CLulbpyIFxwZ3L9RhM6U81704xELIv6nR
 WPM57vpnE3VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175235353"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="gz'50?scan'50,208,50";a="175235353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 15:45:41 -0800
IronPort-SDR: uI7IGFnSgr0mqu/ufbrzPcezKy6IvzTLIFrUGhFxeL55gJefH9ySGdIkdmA/ag+D2zxkbm0DAl
 jfTkroN1RVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="gz'50?scan'50,208,50";a="447302425"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2021 15:45:38 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJPZB-0001Dw-An; Mon, 08 Mar 2021 23:45:37 +0000
Date:   Tue, 9 Mar 2021 07:44:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@01.org, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/2] kvfree_rcu: Release a page cache under memory
 pressure
Message-ID: <202103090709.f6v9Wy9f-lkp@intel.com>
References: <20210308194950.12320-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20210308194950.12320-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Uladzislau,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rcu/dev]
[also build test ERROR on linux/master linus/master v5.12-rc2 next-20210305]
[cannot apply to hnaz-linux-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Uladzislau-Rezki-Sony/kvfree_rcu-Release-a-page-cache-under-memory-pressure/20210309-035155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: arc-defconfig (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d1c3a54d06b2b088b2a7b4e7f2a0a85bcbfbf53a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Uladzislau-Rezki-Sony/kvfree_rcu-Release-a-page-cache-under-memory-pressure/20210309-035155
        git checkout d1c3a54d06b2b088b2a7b4e7f2a0a85bcbfbf53a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: kernel/rcu/tree.o: in function `kvfree_call_rcu':
>> tree.c:(.text+0x291a): undefined reference to `__xchg_bad_pointer'
>> arc-elf-ld: tree.c:(.text+0x291a): undefined reference to `__xchg_bad_pointer'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
8ojfs2q7V+z3PKal8f9/F0JSDnONAAA=

--DocE+STaALJfprDB--
