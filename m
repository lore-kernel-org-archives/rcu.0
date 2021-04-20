Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2F0C433ED
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 10:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4DA611F0
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 10:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhDTKSb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:18:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:24605 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhDTKSa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Apr 2021 06:18:30 -0400
IronPort-SDR: CW//OJ9xmYsARAMOouAG5doy5bDO+4tl2MLUb6TDE8uV331Gws9zJafmxrQPZG+K6ni/UZ2i66
 zCaz9X8MHrAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="193358184"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="193358184"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:17:59 -0700
IronPort-SDR: RzhjjbyyOaoKZC779bZxeIlBManfgNcVB4SlXU2Hygo0L7SRdY34wWlMyzufR/mZRQbiWa5nst
 7HaHzYsBqhww==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="602423215"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:17:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lYnS4-005iE8-HO; Tue, 20 Apr 2021 13:17:52 +0300
Date:   Tue, 20 Apr 2021 13:17:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] bitmap_parse: support 'all' semantics
Message-ID: <YH6qUDJmUflEmper@smile.fi.intel.com>
References: <20210420000131.21038-1-yury.norov@gmail.com>
 <20210420000131.21038-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420000131.21038-2-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 19, 2021 at 05:01:30PM -0700, Yury Norov wrote:
> RCU code supports an 'all' group as a special case when parsing
> rcu_nocbs parameter. This patch moves the 'all' support to the core
> bitmap_parse code, so that all bitmap users can enjoy this extension.
> 
> Moving 'all' parsing to a bitmap_parse level, also allows users to
> pass patterns together with 'all' in regular group:pattern format

...

>  	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
>  	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
>  
> +	{0,	  "all",		&exp1[8 * step], 32, 0},
> +	{0,	  "0, 1, all,  ",	&exp1[8 * step], 32, 0},
> +	{0,	  "all:1/2",		&exp1[4 * step], 32, 0},
> +	{0,	  "ALL:1/2",		&exp1[4 * step], 32, 0},

> +	{-EINVAL, "al", NULL, 8, 0},
> +	{-EINVAL, "alll", NULL, 8, 0},
> +

Looking at the below hunk it seems like the two above should be actually placed
there.

>  	{-EINVAL, "-1",	NULL, 8, 0},
>  	{-EINVAL, "-0",	NULL, 8, 0},
>  	{-EINVAL, "10-1", NULL, 8, 0},
> @@ -384,7 +391,6 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
>  	{-EINVAL, "a-31:10/1", NULL, 8, 0},
>  	{-EINVAL, "0-31:a/1", NULL, 8, 0},
>  	{-EINVAL, "0-\n", NULL, 8, 0},
> -

Otherwise this change doesn't belong to the series.

-- 
With Best Regards,
Andy Shevchenko


