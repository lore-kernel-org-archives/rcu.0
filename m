Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406F2E764D
	for <rcu@vger.kernel.org>; Wed,  9 Sep 2026 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921931; cv=none; b=tpywCZS7x7ozXayHPJejpnzxQ89/59epr8hJ/n11uYEUcfGidsUMJMH5p+9aLhQDAcgDKNYA+lsrZzlAijIoNuO1kzE8AIkatgXie7o2rbX6UGvP0A/VJS/B4rHLrXL3B5bImj3FGMz4Mi0pZ6AQ0GWNjzdV3v/yq/8JsBlyII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921931; c=relaxed/simple;
	bh=iKjBgcV6qBj4WNaEJl9v+SjMxRaoiiKyIb6rZ1jnymY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6Jnd9Ka5xLTdanFMp0WanzaJkIWrDiN7P5dbW9D/cWBhYgwt6cwOQh5tD8Mf3M0HL3P3vgaFyZ49JVBSb3NgWwfrb15MawRI+9ad0Oo/PVx9RO5CDrzi44i27rrnujNb+2Y9x+y2IonrN2TGZfEYYqXL9mON2dlUDKSeHNDkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k518lO3y; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k518lO3y"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso6561307a91.3
        for <rcu@vger.kernel.org>; Tue, 08 Sep 2026 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921930; x=1789526730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPM3JbLDyjCNGhFfICKTDWjoOreg2oE20rUS09/65ns=;
        b=k518lO3yhsSE7fHtBGmAChMOJfKc/5AhMLxPbpnr/92swcezWpFLVOCz1rQLbA3Q9s
         cCLnoJ+j8PmlwsUzELNfaYoI8ONlluBkD0lHy9iOtNOf/JIXVvlbd7Vye9tkAtX09Y5B
         Emg4Waf9AM4a7+Y2Xa5SQ56ZekujDUb4zpOuLCKzKhzVzBwf8e7ZyA5n8TJ+znjrBeOq
         1dz2lXIaZYci4X6JcLAnoKoV1rFYHYYR0vjAisEQWAVHUuC4DQ0ikLpdG5UaYtW4BqqC
         ntTlVMRTuC/vTwF25fnMjTVokAtGdP/h4Tah4L8p53jKKDbjo+Np8gYXVegw6oSnoCQ3
         sz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921930; x=1789526730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EPM3JbLDyjCNGhFfICKTDWjoOreg2oE20rUS09/65ns=;
        b=gWtfROkNNBpDb7SR8n2UKEaIp5TEwBtLgW8vKQ2j+DHwIN+8v6FxP/Q7d6ur1cL/3A
         L9sTaY0nPa2ba64k3e/bxsnNXiABL/h7b/JAnvpPBf48HgR7ZAW55kH+LGh7cg6lJP3U
         F+0+Ins3YPIzm/i5jB5VJIi483guR5kGM7GYoVZIFtLfcm0vl6pampvHnPlO9wjH35JM
         yd51GhQYFW+Lm0kfr33eGjxuTpKjtYE7GMpjc2vZzhOPY03HuO23cR3EXVR3q2arciBb
         arsjKDRDB2PitjJdsiEwGH/LmAqOLbQ36+ZiYJRHVK2mqxXuOzk82V/bOKv5M6ZSdjPu
         +dcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg+ShC2466hkHYPtgHN5jNJOW2tUXrzrhvBrU3I/Ez/lXyg8LkTio063NlcjEAAjFxaMM=@vger.kernel.org
X-Gm-Message-State: AFuF++mRY3MjokSmK4nwivJ0CKzlZOnEbA9jm5zAf1xmGANw9wuEQyoH
	39OBwpfAlLfq3GOFQkHCl2DJea7ek9teFR5iNKZ67cLlauU/W8z0faNU
X-Gm-Gg: AYBFou33Git6qTSwFqFrkfFXKELwifdF6670KW+xZnVBODlQfks+uIkRwoCJA/9KLeD
	nleFbDKJtS4g27kvIzTZMl3MhB4ugG8ZRwnHJH7TsUUInOtBRFJkYPW9TTdKwQuiMB5KTjsYR2i
	7JTgP1SqmYHC1ZdAWB02smFhqoszTWqPJC/xkZiuRdc5DOnzGLLoH49N/J0L2jRCDypi0PAcDis
	pn0hC9r6WUmCpstLKtl1aBu0qwQtDj7xscfBiJ6RwXcAvk7gUbEV9wvhDSX8DVJkLJVJH2VeK1D
	F074iK10qoDdFgImn6djRc02FghE3Awh2zeVb8VpaRfzOgd87E/8wU1H3UBhDOsxyqho4uOpDe+
	P8TcWFUinKKViH4h5ibnJJYLfjurgsV7ScwBq3RyqkVHw0RLEeUM+n6HK6wYMnTXVv9G6BzSzKu
	CBCHwJVxerP2qBWv2l1CPmWa875ZePRQpT7S4xz5h6YqAtyVhZhtk6EYx0jEGOt2INkKloSg==
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39b2624c32bmr13607234a91.21.1788921929295;
        Tue, 08 Sep 2026 19:45:29 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd2aasm28581754a91.3.2026.09.08.19.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:45:28 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
Date: Wed,  9 Sep 2026 10:45:14 +0800
Message-ID: <20260909024515.2429893-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cb71412b-a688-4c70-9365-3f6bd40c9244@paulmck-laptop>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 8 Sep 2026 16:38:19 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Sep 07, 2026 at 03:58:23PM +0800, Kunwu Chan wrote:
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > The transition-to-big code path in srcu_gp_end() calls
> > init_srcu_struct_nodes() with GFP_KERNEL, which is illegal in the
> > atomic context reachable from synchronize_srcu_atomic().  Atomic SRCU
> > has no use for the srcu_node combining tree: it has neither callbacks
> > nor srcu_barrier() operations, and its grace periods are serialized
> > by ->srcu_atomic_gp_flag instead.
> > 
> > Skip this transition entirely for atomic SRCU, which is also defense
> > in depth against any path that might wrongly set ->srcu_size_state for
> > an atomic srcu_struct.
> > 
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> 
> Again, given that we have this commit, is this patch needed?
> 
> 4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")
> 
> And again, if so, please tell me what I am missing.

Yes, this is a separate transition path. That commit suppresses the 
initialization-time transition, while this patch prevents the transition 
from srcu_gp_end(), which can otherwise call 
init_srcu_struct_nodes(..., GFP_KERNEL) for an atomic SRCU.

So this is defense in depth for the atomic path.

Thanks,
KunWu

> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/srcutree.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 01f224a56b41..74acd5645d4c 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1074,8 +1074,9 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
> >  		raw_spin_unlock_irq_rcu_node(sup);
> >  	}
> >  
> > -	/* Transition to big if needed. */
> > -	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> > +	/* Transition to big if needed, but never for atomic SRCU. */
> > +	if (!is_atomic && ss_state != SRCU_SIZE_SMALL &&
> > +	    ss_state != SRCU_SIZE_BIG) {
> >  		if (ss_state == SRCU_SIZE_ALLOC)
> >  			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> >  		else
> > -- 
> > 2.43.0
> > 
> 

Sent using hkml (https://github.com/sjp38/hackermail)
