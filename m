Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0ECC433EF
	for <rcu@archiver.kernel.org>; Mon, 13 Sep 2021 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B9160F51
	for <rcu@archiver.kernel.org>; Mon, 13 Sep 2021 22:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350514AbhIMXAb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:00:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:31672 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344723AbhIMXAP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Sep 2021 19:00:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221864593"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="gz'50?scan'50,208,50";a="221864593"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 15:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="gz'50?scan'50,208,50";a="507583060"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2021 15:58:45 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mPuuS-0007xq-B3; Mon, 13 Sep 2021 22:58:44 +0000
Date:   Tue, 14 Sep 2021 06:57:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chun-Hung Tseng <henrybear327@gmail.com>, paulmck@kernel.org
Cc:     kbuild-all@lists.01.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        Jim Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH] rcu: replace _________p1 with __UNIQUE_ID(rcu)
Message-ID: <202109140643.Ej76cAlN-lkp@intel.com>
References: <20210912204131.93206-1-henrybear327@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20210912204131.93206-1-henrybear327@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chun-Hung,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rcu/dev]
[also build test WARNING on v5.15-rc1 next-20210913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chun-Hung-Tseng/rcu-replace-_________p1-with-__UNIQUE_ID-rcu/20210913-044418
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
reproduce: make htmldocs

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

include/linux/rcupdate.h:379: warning: expecting prototype for unrcu_pointer(). Prototype was for __unrcu_pointer() instead

vim +379 include/linux/rcupdate.h

53ecfba259f54b Paul E. McKenney 2010-09-13  366  
76c8eaafe4f061 Paul E. McKenney 2021-04-21  367  /**
76c8eaafe4f061 Paul E. McKenney 2021-04-21  368   * unrcu_pointer - mark a pointer as not being RCU protected
76c8eaafe4f061 Paul E. McKenney 2021-04-21  369   * @p: pointer needing to lose its __rcu property
76c8eaafe4f061 Paul E. McKenney 2021-04-21  370   *
76c8eaafe4f061 Paul E. McKenney 2021-04-21  371   * Converts @p from an __rcu pointer to a __kernel pointer.
76c8eaafe4f061 Paul E. McKenney 2021-04-21  372   * This allows an __rcu pointer to be used with xchg() and friends.
76c8eaafe4f061 Paul E. McKenney 2021-04-21  373   */
6744ef711df006 Chun-Hung Tseng  2021-09-13  374  #define __unrcu_pointer(p, local)					\
76c8eaafe4f061 Paul E. McKenney 2021-04-21  375  ({									\
6744ef711df006 Chun-Hung Tseng  2021-09-13  376  	typeof(*p) *local = (typeof(*p) *__force)(p);			\
76c8eaafe4f061 Paul E. McKenney 2021-04-21  377  	rcu_check_sparse(p, __rcu);					\
6744ef711df006 Chun-Hung Tseng  2021-09-13  378  	((typeof(*p) __force __kernel *)(local)); 			\
76c8eaafe4f061 Paul E. McKenney 2021-04-21 @379  })
6744ef711df006 Chun-Hung Tseng  2021-09-13  380  #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
76c8eaafe4f061 Paul E. McKenney 2021-04-21  381  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--u3/rZRmxL6MmkK24--
