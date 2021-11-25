Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3094C4332F
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 11:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhKYLpE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:45:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:33802 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236060AbhKYLnC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Nov 2021 06:43:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="222372137"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222372137"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:38:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457380120"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:38:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqD4i-00AQ2A-UF;
        Thu, 25 Nov 2021 13:38:00 +0200
Date:   Thu, 25 Nov 2021 13:38:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <YZ91mJ0kmTjh3sRx@smile.fi.intel.com>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
 <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
 <20211125044132.GA105778@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125044132.GA105778@lapt>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 24, 2021 at 08:41:32PM -0800, Yury Norov wrote:
> On Wed, Nov 24, 2021 at 04:47:20PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 23, 2021 at 01:37:07AM +0100, Frederic Weisbecker wrote:

...

> +	if (!strncasecmp(str, "none", 4)) {
> +		r->start = 0;
> +		r->end = 0;
> +		r->off = 0;
> +		r->group_len = r->nbits;
> +		str += 4;

> +		goto out;

Side remark, I would make the name of the label a bit more verbose on what it's
going to be done there, "out_end_of_region:" or alike.

> +	}

-- 
With Best Regards,
Andy Shevchenko


