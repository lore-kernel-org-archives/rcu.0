Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4947C433ED
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 10:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D3E613B0
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 10:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDTKTt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:19:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:32092 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTKTt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Apr 2021 06:19:49 -0400
IronPort-SDR: nXQCmfiJo2UNZfZRR9Bivdl293DE55dizKWc/HbDxOT95qfK8oSonCEZZGU4+2TPFKViE5Sy36
 A0h8XKWJ78vw==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182613274"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="182613274"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:19:17 -0700
IronPort-SDR: t3ADhHXhqijj1LQOMzquan2ijzmI1t3zxWAB2jKPB7MhItZr09UYSnKPfjN4qjb5j3pgBuiU7t
 6I2+aXFnPo8w==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="420351253"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:19:14 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lYnTL-005iEs-5X; Tue, 20 Apr 2021 13:19:11 +0300
Date:   Tue, 20 Apr 2021 13:19:11 +0300
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
Subject: Re: [PATCH 0/2] bitmap_parselist: support 'all' semantics
Message-ID: <YH6qnzU9iCg6Fvjs@smile.fi.intel.com>
References: <20210420000131.21038-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420000131.21038-1-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 19, 2021 at 05:01:29PM -0700, Yury Norov wrote:
> RCU code supports a special group 'all' which selects all bits in a bitmap.
> We have recently added 'N' extension for bitmap parse, so that '0-N' would
> have exactly the same meaning as 'all'. But because the 'all' is already
> used by RCU, it would be reasonable to support it in core bitmap code as a
> common and easy-readable alias for '0-N'.
> 
> Moving the 'all' support to core bitmap code adds another level of
> flexibility for system configuration by supporting patterns. For example,
> every second bit in cpumask may be selected like this:
> 	isolcpus=all:1/2

After addressing a couple of nit-picks,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Yury Norov (2):
>   bitmap_parse: support 'all' semantics
>   rcu/tree_plugin: don't handle the case of 'all' CPU range
> 
>  Documentation/admin-guide/kernel-parameters.rst | 5 +++++
>  kernel/rcu/tree_plugin.h                        | 9 +++------
>  lib/bitmap.c                                    | 9 +++++++++
>  lib/test_bitmap.c                               | 8 +++++++-
>  4 files changed, 24 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


