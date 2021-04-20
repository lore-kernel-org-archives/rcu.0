Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF052C433B4
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 10:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AAF6103E
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 10:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhDTKTY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:19:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:32063 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhDTKTU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Apr 2021 06:19:20 -0400
IronPort-SDR: F1J+VgjckoBCZt/399hDqwS1w11kZZSZE+O8hbqp5+XXYaK4HM+FQk7s8YmqpwRMk9JBSAgRee
 nU44gjyDxbQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182613236"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="182613236"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:18:47 -0700
IronPort-SDR: X32PcU0J9ESokyJ7hWE07zjQM3yfdTAscd0Ou033xdH6yW0TOMjwKDOOazckMzRdSCEkfJ5BGw
 a0B2pKKGxfkw==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="426866968"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:18:43 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lYnSq-005iEa-GB; Tue, 20 Apr 2021 13:18:40 +0300
Date:   Tue, 20 Apr 2021 13:18:40 +0300
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
Subject: Re: [PATCH 2/2] rcu/tree_plugin: don't handle the case of 'all' CPU
 range
Message-ID: <YH6qgHH1RtBCHxEy@smile.fi.intel.com>
References: <20210420000131.21038-1-yury.norov@gmail.com>
 <20210420000131.21038-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420000131.21038-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 19, 2021 at 05:01:31PM -0700, Yury Norov wrote:
> The 'all' semantics is now supported by the bitmap_parselist() so we can
> drop supporting it as a special case in RCU code. This patch does not
> add any functional changes for existing users.

> -	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */

Perhaps move comment as well to new location.

-- 
With Best Regards,
Andy Shevchenko


