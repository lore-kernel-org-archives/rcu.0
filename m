Return-Path: <SRS0=cCdg=SF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CCC4360F
	for <rcu@archiver.kernel.org>; Wed,  3 Apr 2019 18:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC520882
	for <rcu@archiver.kernel.org>; Wed,  3 Apr 2019 18:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="K82tE2mG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDCSbP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:31:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46685 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDCSbN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Apr 2019 14:31:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id x188so14405250oia.13
        for <rcu@vger.kernel.org>; Wed, 03 Apr 2019 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGyOEoxy0h99gsusBdQVGr14JAL4WdfFO3oAZW2FLVs=;
        b=K82tE2mGbkfbDv/ZMwdn2vS34AGRa8573cH/nOfXtricK6qHk2WruUr1jEHi/JPnXV
         vWxTeXlW66+TJ1NbEvo1lrtb3vYU+bqXNe0Qrx5Uoq3sc4YDHNNtCOvOOf4+FqSjdFsa
         pOoZQ5neek+VAx7fOLXhKPMlurb9qAEtyn2RqpAVr24wGx0Fs6eFUjEk0mCydcuxhOBY
         EqtaZWO6vXg4UVn3DbNsTTqexizZMU2QIiAKrGzBH6wD1q8cKP6AAbpjs5TKrWrfyOa1
         r4KWwti4xfuXWzoHYsHPBLF7WwXni4OkLXXBxHfwBXnkuIQ3a1+CB/Nc+Q0xbiuDymGR
         CLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGyOEoxy0h99gsusBdQVGr14JAL4WdfFO3oAZW2FLVs=;
        b=Jo4FZPotyGsLL9HriGrHUitkodC1QaXBBsSeoFc5KdJo1vJ4rYY7sNU5Kzzdf7uhaS
         PGREHDT0WO5OicGzli5wSn37Pu0kI649nIGNSQWwn7S0QpVJzwk9fqBaXSWI9sBh4uT9
         PYgkE55+a2HrwFmk6SOk4mXBfB50bkgnQdAZDLpSYz08Xfqaz2gupw+4c38oIDerRD06
         EeWMWAHlXVDCcmS5S0Z1sgdyzhVjRRmWFiD1a63LsMDNhM5tBYdQ5gljO+AkH4E9XilM
         2BikJU2jNzK9NVkScPg2joJfY74faJ96s7lvRFKTk+t0fKCalI+n+FkflsFscapFUSAO
         EJaw==
X-Gm-Message-State: APjAAAV/DL3Bqwlals64cvOrb0cWR9Z+SUalxMCjBw5Nz00XsLrh5yJi
        1Yw4I1LgYR0YPTYGCRXGg7tn1PBr1DJhEJYt68xtmdcMfF4=
X-Google-Smtp-Source: APXvYqy5zjcoJ2avp8UeuvRXQCAhzPmvu0BeDnN5WLnF6of2XTu8J+cpcrq0tNVk3mzxziWnqwlUeLwz8FrjyibkgAs=
X-Received: by 2002:aca:f581:: with SMTP id t123mr660054oih.0.1554316272610;
 Wed, 03 Apr 2019 11:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190402142816.GA13084@linux.ibm.com> <20190402142933.14547-1-paulmck@linux.ibm.com>
In-Reply-To: <20190402142933.14547-1-paulmck@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Apr 2019 11:31:01 -0700
Message-ID: <CAPcyv4gOQ_KpZm8ediav4O-cLzqP6Fsd3ZmFC-AKeAh77i0N+A@mail.gmail.com>
Subject: Re: [PATCH RFC tip/core/rcu 1/4] dax/super: Dynamically allocate dax_srcu
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>, fweisbec@gmail.com,
        Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Tejun Heo <tj@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 2, 2019 at 7:29 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
> requires that the size of the reserved region be increased, which is
> not something we really want to be doing.  This commit therefore removes
> the DEFINE_STATIC_SRCU() from drivers/dax/super.c in favor of defining
> dax_srcu as a simple srcu_struct, initializing it in dax_core_init(),
> and cleaning it up in dax_core_exit().
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
