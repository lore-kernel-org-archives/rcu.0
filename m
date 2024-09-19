Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0E191F7D;
	Thu, 19 Sep 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729845; cv=none; b=JFfbCWxHDhDEM5Op1oh8g499bnEVy8BARPL/HEcftDa+wS3qgJj3B2Fw12TcJbMm61JFAegPdkzoGG/LcstZGzi1QNk+tmOZ+JGyjE45DHopMCSp1pWypGyGHXDPiOsOJZOZavn7ZetsnBMJYnfGNSg3qZAgocorCEZRAOupoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729845; c=relaxed/simple;
	bh=3QHzNYn6bQo9WZIWRe3nhGOkEDPFAhwWWERWCitveaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkKrgJZPLtbzhRgVYgnRqsxvk+kDYsfe53JhtLsaijiStrTbRFOy9+gdbymSVeM5ifyBLAU5LvgoDB/2YEbgYqkT6/XI/TEW37VBd+Daah02e6Z5xt3OJY63f9LmQFOEUw2EVc0HmL+6sUc4NQCXkB3kRm1jk0AyXFqQbLXegBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2ENpv2E; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2ENpv2E"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45821eb62daso2760491cf.3;
        Thu, 19 Sep 2024 00:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726729843; x=1727334643; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7QO2c7/I67RlCRDcr/Y3qX9Q299kYfHctBt13qLUVFY=;
        b=L2ENpv2E7SfesfqD5Sa8kdB/FRB0ydtRqxsCdhtu82+Y34uXMbQCK3Ui0Va0NkkD5X
         6OAkZcg9wCFmS1uz57SUlJyoWST/zHXYBkEkwUwB5G6gbADpB7VQFnmqq5i++OVU0axq
         dG+nkivRZHwc5Ii2T6l/0bIMAhW66TYq+dSkmSw+gKKcqhAUr9x7uhis4VQazIJrBWGP
         jVuOuYHmVG8BlE9dhYLkHOfdKoz3Zx49KndRcpq7TMTvA3c4demR0bRR/LbjBwGpmuen
         vlcmlM1PDHw7t9ucL9HsK6FxjlPkxBnuuw3gU0R/jdoifFhPfm1zHQtkY0bNSSTJHWh0
         DZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726729843; x=1727334643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QO2c7/I67RlCRDcr/Y3qX9Q299kYfHctBt13qLUVFY=;
        b=nXHMeh0gu5fz94WyX68g+Jwb+PcVRF8si9eXbRF2xEobHBOw+I/3yY2768j80HYiOd
         W7WK/8z8hXMESv4iz1BAPxvTv6D8CmlEq2lE28vxeU2GRTnbZwpQjj9ERTwmk3uNwQCu
         +UmddoRCy9WdkyYy32GtO9jetxMr1anqsvnvQO7U+Yo4KCHAiaPqdoVWLMf2ZgWH09tM
         YbL0InO7Zv5zuXbG4W15mfkucT2fPNLWA+IVjrdHmTIJe2R/XaX5IVu7SNRHw68Me1ZS
         NHjiwxgeGeWruKcr2JgLA12hj8n4IA5fJzP4kNacelD62DMJjsHKLEdl2mLza3CR9D+g
         HGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPvdnZr3tylaztCJvLGhP3xn33jMTf6YqZEFoKm+I6g9VFEZ/iKaeohnl5wemmo6Oy2sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQhJMWLtM+ASf0hJCGav1PN9vTMBtYRjsCbMEzRcJLohJoeuM
	408uT1bJCgUgwNt8ex/3gC/HmJLIA+Zf2/I/udz1PtB5t8GJqglb
X-Google-Smtp-Source: AGHT+IEKX3hg+/XrCUs3vNj5lGyvUgv9sa2s1gAeDJdkuaQ80BEsYKQrkSosZ6GkHLs9lV7qEOSmyg==
X-Received: by 2002:ac8:7d02:0:b0:458:52f0:9bd8 with SMTP id d75a77b69052e-45860422a45mr368514221cf.53.1726729842653;
        Thu, 19 Sep 2024 00:10:42 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b1788c181sm4461881cf.52.2024.09.19.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 00:10:42 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 785DF120006E;
	Thu, 19 Sep 2024 03:10:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Sep 2024 03:10:41 -0400
X-ME-Sender: <xms:cc7rZuL2KHpOmhysjtNv0J7Ul8PR7rUZN3DoM0IJ3r6a8DlgJP2TWw>
    <xme:cc7rZmJGjq1YIbKuEKmvp_m-f2H2otINvkQIvm4WugGtWuwCX4nrEY_VcMmFGj1vS
    VP9l1ElaNCrSdGXiA>
X-ME-Received: <xmr:cc7rZutbiI7QMFsGerMXhXO1junoCRgmS3xkGcxhooXxLWitXXvBCL12Q7E1yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeltddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhk
    mhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepphgruhhlmhgtkheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrgh
X-ME-Proxy: <xmx:cc7rZjaxK_4FLYRunDorIZ-lf25ZimazwKmlXG46oFpPRf3L9lzu7A>
    <xmx:cc7rZla83OcqCw74lEFDI8tUAfKrwQy1gRULvYEF5yYrO2ObvuvAEA>
    <xmx:cc7rZvAQYL5oabCq1Osgi2S5AgTTt_efQM4zVLG7_gwJ_Jhp_dO3-Q>
    <xmx:cc7rZrZn_I1vzu8Fd8uR4iTOucHrGzc2_PeN2iElgMelzfyzGemshw>
    <xmx:cc7rZlp5HrKHc67ffqs2cwdsK-oZ-hz1GIKWGvtCe701TrMNTdD3AeWN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Sep 2024 03:10:40 -0400 (EDT)
Date: Thu, 19 Sep 2024 00:10:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
	lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
Message-ID: <ZuvOWM5c8tZotHFL@boqun-archlinux>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <CAJhGHyD8MzUssfuKSGnu1arnayNOyBnUA03vYB0WWwbE3WzoZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyD8MzUssfuKSGnu1arnayNOyBnUA03vYB0WWwbE3WzoZg@mail.gmail.com>

On Thu, Sep 19, 2024 at 02:39:13PM +0800, Lai Jiangshan wrote:
> On Tue, Sep 17, 2024 at 10:34 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > +static void hazptr_context_snap_readers_locked(struct hazptr_reader_tree *tree,
> > +                                              struct hazptr_context *hzcp)
> > +{
> > +       lockdep_assert_held(hzcp->lock);
> > +
> > +       for (int i = 0; i < HAZPTR_SLOT_PER_CTX; i++) {
> > +               /*
> > +                * Pairs with smp_store_release() in hazptr_{clear,free}().
> > +                *
> > +                * Ensure
> > +                *
> > +                * <reader>             <updater>
> > +                *
> > +                * [access protected pointers]
> > +                * hazptr_clear();
> > +                *   smp_store_release()
> > +                *                      // in reader scan.
> > +                *                      smp_load_acquire(); // is null or unused.
> > +                *                      [run callbacks] // all accesses from
> > +                *                                      // reader must be
> > +                *                                      // observed.
> > +                */
> > +               hazptr_t val = smp_load_acquire(&hzcp->slots[i]);
> > +
> > +               if (!is_null_or_unused(val)) {
> > +                       struct hazptr_slot_snap *snap = &hzcp->snaps[i];
> > +
> > +                       // Already in the tree, need to remove first.
> > +                       if (!is_null_or_unused(snap->slot)) {
> > +                               reader_del(tree, snap);
> > +                       }
> > +                       snap->slot = val;
> > +                       reader_add(tree, snap);
> > +               }
> > +       }
> > +}
> 
> Hello
> 
> I'm curious about whether there are any possible memory leaks here.
> 
> It seems that call_hazptr() never frees the memory until the slot is
> set to another valid value.
> 
> In the code here, the snap is not deleted when hzcp->snaps[i] is null/unused
> and snap->slot is not which I think it should be.
> 
> And it can cause unneeded deletion and addition of the snap if the slot
> value is unchanged.
> 

I think you're right. (Although the node will be eventually deleted at
cleanup_hazptr_context(), however there could be a long-live
hazptr_context). It should be:

		hazptr_t val = smp_load_acquire(&hzcp->slots[i]);
		struct hazptr_slot_snap *snap = &hzcp->snaps[i];

		if (val != snap->slot) { // val changed, need to update the tree node.
			// Already in the tree, need to remove first.
			if (!is_null_or_unused(snap->slot)) {
				reader_del(tree, snap);
			}

			// use the latest snapshot.
			snap->slot = val;

			// Add it into tree if there is a reader
			if (!is_null_or_unused(val))
				reader_add(tree, snap);
		}

Regards,
Boqun

> I'm not so sure...
> 
> Thanks
> Lai
