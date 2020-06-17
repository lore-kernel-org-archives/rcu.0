Return-Path: <SRS0=aJiN=76=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B05C433DF
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B624321556
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 23:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592437570;
	bh=M7bG+rSHSEDHF2Qry9Zk4SV+gGKCbl4sGRVOdFojW+4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=m2tRDR+6CBJ4CMGaHcGlov3/XHj6cbSjWxjXc5aYD8OTP7CJgbgtDo3imJVy7FzyJ
	 DixHEmJgnmXx2o0wDOBPZuCI51X4B0/GK37XWyApzlqwEnxSxMO2WFLS58PEMjK864
	 uKBvbEz+kFC8VnTIcyxEXjtBYd9ONyHzoXuqFWpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQXqK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgFQXqK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Jun 2020 19:46:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F23207E8;
        Wed, 17 Jun 2020 23:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592437569;
        bh=M7bG+rSHSEDHF2Qry9Zk4SV+gGKCbl4sGRVOdFojW+4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HUfgpYwyNBOTeYNYb/UuaWuV4M7LYIjs+fIVd5OF+TCaLqEQK6a+xaIbb50JIhdB0
         4X7NuWBSpb4wZVP5UmBhN27cOT0A7G0HYtfTZVvGhv+4D/SC7XlLxcI+022GMzRi0c
         mesUzHw/QEVJ9z3YjRh+D1v2du+ew+W9r2Xz6iWY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6B8B03523551; Wed, 17 Jun 2020 16:46:09 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:46:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200617234609.GA10087@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525214800.93072-10-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 25, 2020 at 11:47:53PM +0200, Uladzislau Rezki (Sony) wrote:
> To do so, we use an array of kvfree_rcu_bulk_data structures.
> It consists of two elements:
>  - index number 0 corresponds to slab pointers.
>  - index number 1 corresponds to vmalloc pointers.
> 
> Keeping vmalloc pointers separated from slab pointers makes
> it possible to invoke the right freeing API for the right
> kind of pointer.
> 
> It also prepares us for future headless support for vmalloc
> and SLAB objects. Such objects cannot be queued on a linked
> list and are instead directly into an array.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

[ . . . ]

> +	// Handle two first channels.
> +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> +		for (; bkvhead[i]; bkvhead[i] = bnext) {
> +			bnext = bkvhead[i]->next;
> +			debug_rcu_bhead_unqueue(bkvhead[i]);
> +
> +			rcu_lock_acquire(&rcu_callback_map);
> +			if (i == 0) { // kmalloc() / kfree().
> +				trace_rcu_invoke_kfree_bulk_callback(
> +					rcu_state.name, bkvhead[i]->nr_records,
> +					bkvhead[i]->records);
> +
> +				kfree_bulk(bkvhead[i]->nr_records,
> +					bkvhead[i]->records);
> +			} else { // vmalloc() / vfree().
> +				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> +					trace_rcu_invoke_kfree_callback(
> +						rcu_state.name,
> +						bkvhead[i]->records[j], 0);
> +
> +					vfree(bkvhead[i]->records[j]);
> +				}
> +			}
> +			rcu_lock_release(&rcu_callback_map);

Not an emergency, but did you look into replacing this "if" statement
with an array of pointers to functions implementing the legs of the
"if" statement?  If nothing else, this would greatly reduced indentation.

I am taking this as is, but if you have not already done so, could you
please look into this for a follow-up patch?

							Thanx, Paul
