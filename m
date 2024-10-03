Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D8DF51;
	Thu,  3 Oct 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915142; cv=none; b=GBUYBlF5Qumo7jPOFEsexxxyFg1IGH/VVADbXqCHYZoIvqO2sKvs9FdIx11DdX5dQiMenMW2DYZizbV1c8ZWVXf8VBB7DAFYwiIvUMO6+HjUWNMlA67ELBhVNSUkCkTS/ioKkCGw6MbsE3sr8slKKNZf/+xI1txDLR36NMautNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915142; c=relaxed/simple;
	bh=hvYsIbbz3yxpjZGd/GNq8vszwKEsNA2zbpOrZOHdrx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAZ8W8drHlbe93p2Y2rJfcUQZ7CYNIWPtBAQo0XrnHuZy98MYi5QQqafjxsFQotoxFFKcoawou8wES/98MTPADK9QcgHTw7b7CclCAeFxD06KpcAI+ZfVKfOkj3S5or480xOJIM4ciHzFtb19c/GBf9M4+O9NPpAFfDqB0pmWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISebJI5B; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISebJI5B"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2a6d3144so2246726d6.2;
        Wed, 02 Oct 2024 17:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727915138; x=1728519938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdmBFtAuO1xuuA1xbvQwfI32coSRJZlqI5hdaMf3qvc=;
        b=ISebJI5BzTSeWzyezyar+8T6aLdqk9HYc4xwEdrpsgKrOdT8GeX1eWgXDqpcf7N2mm
         unfOG0rYRsq9JXSTjG7Gz3C/xyCznXKlHPecXZYujJ+Lxt2U3UWYlyX/7jlSYYPzxKQh
         LtJ/5TuT5M7UFiwQwWoHVAYEnSrEMVGhl8GFWgiJj5+7dwFpQ0khc/rA5koGg888x1Os
         bkY5depnsg8JRGiu6wS/2MnH8BgyElOWhSnWQRyLNr3f9kw+w3a+Ri55a4yH7WropCLl
         jQ4vHVGaaUvlFhnFmptSZZjbV4dUkvuHfms+XBO638r+/izhmEczISnLksFWUVYvjndb
         hleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727915138; x=1728519938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdmBFtAuO1xuuA1xbvQwfI32coSRJZlqI5hdaMf3qvc=;
        b=sKGDCq9+Ja3kl+XuLCuOdJdYEiD4mLNZXNsGR+Bid9NsaPJqhcN0uqdpVUXibmNJni
         /MfinuQ4BcKgQSHbEyXWoWkAlmeJlTB2YWCW5+ns+K52nHChzE3hqWbn1HzWalvVNgis
         xczMFIYmqdTViAT81AorMwbuGHtvd2IWcy+bDcgBHcEr3Qh9hCipKbxhEi0iEDUVLsJO
         xoAre3otbpnx5BF8QHoSbpV+zXFSCae3Yh8nt+KHrFCfZbL+fz3V6FrbJ4K9jeZh46bL
         naDjig4dKMHWcmy/zjS4dLCD7/aBM464FP+spzIvfTc/Rzkqssn32zQnar8lDeUae3v2
         cMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+cuAYReMi2rEHoIs0Y4fF7GBttHseNmiB+ndwvN4sa1ems6N+8KzMTm43Eq6eOVc1Oa7a@vger.kernel.org, AJvYcCUw4K5MW7983VD+EBWXDJUaoiBIvUSTmBfs45G2kIlUYvD+WItvY8EDMbSBmfKkxJjRTrlp5acbg0yZnjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeP9+6AViVlswJ7Wk2ginUJJgMsWpIpbhpO2WHjioyQ8XXk8z0
	KFSGlPTh9om0a4qJeLsRbGaLp6iEeGQ7EHTD+rnNn6ItVsmgE6Qz
X-Google-Smtp-Source: AGHT+IGnKF3a9DMxLqjSehWRMwSs/R7LCv/5apMPogn0UWIcgsZAqe38g270iV/q54p8i8gQNXFtXg==
X-Received: by 2002:a05:6214:1932:b0:6cb:8266:bef1 with SMTP id 6a1803df08f44-6cb8266c00emr59910906d6.0.1727915138385;
        Wed, 02 Oct 2024 17:25:38 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d9299ec6bsm26281cf.53.2024.10.02.17.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 17:25:37 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 061921200068;
	Wed,  2 Oct 2024 20:25:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 20:25:37 -0400
X-ME-Sender: <xms:gOT9Zh7C03D5vooBIbOBV0dNIiWJDT8WMbsmM6Q827FWi5Q7PG7fYQ>
    <xme:gOT9Zu62Lop7pqWZGJpXAq79J-DYfbj_fr2KfUzrl4Ykg72N9RcMEVwHuLoc42bbe
    D_i2Fi9HiA9LxG3qQ>
X-ME-Received: <xmr:gOT9ZocPBs0x-ZDCvHstaGOxdThpjHqI8MKEipPh_x_R2-WMvn-LsVaUTQrouQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhteffveeuhefhveefgfehvdejkeefuefgfeeg
    vedtheegvdelueevvdegteffueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlph
    gtrdgvvhgvnhhtshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgt
    ihhoshdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    hpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinh
    huthhrohhnihigrdguvg
X-ME-Proxy: <xmx:gOT9ZqJS32RFUPPIhiHJWhi8jNycW3T5lyH6Vl7Ou6mUreYr8QGtMw>
    <xmx:gOT9ZlJ_73yoBrJuQL_I61Bci_3PTpOORhGj3HzdXEkAIGIXdVQRcQ>
    <xmx:gOT9Zjx-21pV8dm1eA9cIiEjAk-fduc9xble8NtMVrbceoteyB1ofw>
    <xmx:gOT9ZhI5zLyIfqZssyOsRSbUnmgNFzFPncCNIDgbs4Wc1AdJGBC9xQ>
    <xmx:geT9ZoZFgx8h4dK8R5bg93Dqrpqs8J0xlrhHOBmLiViYRcw3M-yXeAjQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 20:25:36 -0400 (EDT)
Date: Wed, 2 Oct 2024 17:24:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,	rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH 3/4] hp: Implement Hazard Pointers
Message-ID: <Zv3kP477pGeOxuu9@boqun-archlinux>
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <20241002010205.1341915-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002010205.1341915-4-mathieu.desnoyers@efficios.com>

On Tue, Oct 01, 2024 at 09:02:04PM -0400, Mathieu Desnoyers wrote:
> This API provides existence guarantees of objects through Hazard
> Pointers (HP).
> 
> Each HP domain defines a fixed number of hazard pointer slots (nr_cpus)
> across the entire system.
> 
> Its main benefit over RCU is that it allows fast reclaim of
> HP-protected pointers without needing to wait for a grace period.
> 
> It also allows the hazard pointer scan to call a user-defined callback
> to retire a hazard pointer slot immediately if needed. This callback
> may, for instance, issue an IPI to the relevant CPU.
> 
> There are a few possible use-cases for this in the Linux kernel:
> 
>   - Improve performance of mm_count by replacing lazy active mm by HP.
>   - Guarantee object existence on pointer dereference to use refcount:
>     - replace locking used for that purpose in some drivers,
>     - replace RCU + inc_not_zero pattern,
>   - rtmutex: Improve situations where locks need to be taken in
>     reverse dependency chain order by guaranteeing existence of
>     first and second locks in traversal order, allowing them to be
>     locked in the correct order (which is reverse from traversal
>     order) rather than try-lock+retry on nested lock.
> 
> References:
> 
> [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
>      lock-free objects," in IEEE Transactions on Parallel and
>      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
> 
> Link: https://lore.kernel.org/lkml/j3scdl5iymjlxavomgc6u5ndg3svhab6ga23dr36o4f5mt333w@7xslvq6b6hmv/
> Link: https://lpc.events/event/18/contributions/1731/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> ---
>  include/linux/hp.h | 154 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/Makefile    |   2 +-
>  kernel/hp.c        |  46 ++++++++++++++
>  3 files changed, 201 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/hp.h
>  create mode 100644 kernel/hp.c
> 
> diff --git a/include/linux/hp.h b/include/linux/hp.h
> new file mode 100644
> index 000000000000..929e8685a0fd
> --- /dev/null
> +++ b/include/linux/hp.h
> @@ -0,0 +1,154 @@
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> +//
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +
> +#ifndef _LINUX_HP_H
> +#define _LINUX_HP_H
> +
> +/*
> + * HP: Hazard Pointers
> + *
> + * This API provides existence guarantees of objects through hazard
> + * pointers.
> + *
> + * It uses a fixed number of hazard pointer slots (nr_cpus) across the
> + * entire system for each HP domain.
> + *
> + * Its main benefit over RCU is that it allows fast reclaim of
> + * HP-protected pointers without needing to wait for a grace period.
> + *
> + * It also allows the hazard pointer scan to call a user-defined callback
> + * to retire a hazard pointer slot immediately if needed. This callback
> + * may, for instance, issue an IPI to the relevant CPU.
> + *
> + * References:
> + *
> + * [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
> + *      lock-free objects," in IEEE Transactions on Parallel and
> + *      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
> + */
> +
> +#include <linux/rcupdate.h>
> +
> +/*
> + * Hazard pointer slot.
> + */
> +struct hp_slot {
> +	void *addr;
> +};
> +
> +/*
> + * Hazard pointer context, returned by hp_use().
> + */
> +struct hp_ctx {
> +	struct hp_slot *slot;
> +	void *addr;
> +};
> +
> +/*
> + * hp_scan: Scan hazard pointer domain for @addr.
> + *
> + * Scan hazard pointer domain for @addr.
> + * If @retire_cb is NULL, wait to observe that each slot contains a value
> + * that differs from @addr.
> + * If @retire_cb is non-NULL, invoke @callback for each slot containing
> + * @addr.
> + */
> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr));
> +
> +/* Get the hazard pointer context address (may be NULL). */
> +static inline
> +void *hp_ctx_addr(struct hp_ctx ctx)
> +{
> +	return ctx.addr;
> +}
> +
> +/*
> + * hp_allocate: Allocate a hazard pointer.
> + *
> + * Allocate a hazard pointer slot for @addr. The object existence should
> + * be guaranteed by the caller.
> + *
> + * Returns a hazard pointer context.
> + */
> +static inline
> +struct hp_ctx hp_allocate(struct hp_slot __percpu *percpu_slots, void *addr)
> +{
> +	struct hp_slot *slot;
> +	struct hp_ctx ctx;
> +
> +	if (!addr)
> +		goto fail;
> +	slot = this_cpu_ptr(percpu_slots);

Are you assuming this is called with preemption disabled? Otherwise,
there could two threads picking up the same hazard pointer slot on one
CPU,

> +	/*
> +	 * A single hazard pointer slot per CPU is available currently.
> +	 * Other hazard pointer domains can eventually have a different
> +	 * configuration.
> +	 */
> +	if (READ_ONCE(slot->addr))
> +		goto fail;

.. and they could both read an empty slot, and both think they
successfully protect the objects, which could be different objects.

Or am I missing something subtle here?

> +	WRITE_ONCE(slot->addr, addr);	/* Store B */
> +	ctx.slot = slot;
> +	ctx.addr = addr;
> +	return ctx;
> +
> +fail:
> +	ctx.slot = NULL;
> +	ctx.addr = NULL;
> +	return ctx;
> +}
> +
> +/*
> + * hp_dereference_allocate: Dereference and allocate a hazard pointer.
> + *
> + * Returns a hazard pointer context.
> + */
> +static inline
> +struct hp_ctx hp_dereference_allocate(struct hp_slot __percpu *percpu_slots, void * const * addr_p)
> +{
> +	struct hp_slot *slot;
> +	void *addr, *addr2;
> +	struct hp_ctx ctx;
> +
> +	addr = READ_ONCE(*addr_p);
> +retry:
> +	ctx = hp_allocate(percpu_slots, addr);
> +	if (!hp_ctx_addr(ctx))
> +		goto fail;
> +	/* Memory ordering: Store B before Load A. */
> +	smp_mb();
> +	/*
> +	 * Use RCU dereference without lockdep checks, because
> +	 * lockdep is not aware of HP guarantees.
> +	 */
> +	addr2 = rcu_access_pointer(*addr_p);	/* Load A */

Why rcu_access_pointer() instead of READ_ONCE()? Because you want to
mark the head of address dependency?

Regards,
Boqun

> +	/*
> +	 * If @addr_p content has changed since the first load,
> +	 * clear the hazard pointer and try again.
> +	 */
> +	if (!ptr_eq(addr2, addr)) {
> +		WRITE_ONCE(slot->addr, NULL);
> +		if (!addr2)
> +			goto fail;
> +		addr = addr2;
> +		goto retry;
> +	}
> +	ctx.slot = slot;
> +	ctx.addr = addr2;
> +	return ctx;
> +
> +fail:
> +	ctx.slot = NULL;
> +	ctx.addr = NULL;
> +	return ctx;
> +}
> +
[...]
