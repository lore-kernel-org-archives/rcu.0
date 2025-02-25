Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50031898E9
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499876; cv=none; b=Hv7geD+23nYiOjKMW0e8mrIooNv3NZIAenMcLe3zVtemszrcCcHIy/KoZVJgvdaylxaHd87L+442Mt9EjpBANzvhr5IoWK71YNSrwWjvt6y+FVA70g+O33GUvc3KowBEPku6EaW8aM9b8FOu4i+bCfLfmRbiCuWyL/6h4EzfXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499876; c=relaxed/simple;
	bh=b+g9TWpP+/BL8lGvFhasPKnV+EYw8HGPOaolrDXVsXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci9dGi5umEYzBBdg3rIeB/H9ScVI7cazxEGZI53v4aX9UvrBae77cbfoELuja5pWi7L4+0tuyh1+pkKm1HDP3p+wFNE7c/p7DuZYEh6CU4/+8YdEKtel6PpiS5YsDuuk4esRZz+e24f3+dSttoT1Qb99AuSeE/KVaWVPz8hMFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3dXwAKa; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3dXwAKa"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0ade6036aso655684485a.0
        for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 08:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740499873; x=1741104673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDJCZB9Pp6uRzDdb8U10QpXTANbtNp6AMax/hSuxDnA=;
        b=k3dXwAKaAK2FTSX61jtTxg1pty2aedOOulk0YSf6VaWB1Ld4c0BnK5WlHnEYhK7CHB
         /PhGWpQWSYd8q2C1weV3ROmRJXalLfD8UEgSf036Pjx6Dl7oizNavfx2IoHrg0nkEYz6
         vx+vDDDjRrMlu68DEi8lEX2M6zLeM5e0gKrg/YhobREQzkH8naDborgoSSo80G3Mubnz
         53zBvCQpiKyLnEAqP/KyMWd9/6RXYHOr2UY1caOxos3/WXEF6tJxyJSTPG49fpMcqQ9S
         r0y9FUndb78h5hkdavGgY2T4Sz4MRKQZRA9egiIq3vj1pVc6xBsZaS81GGHJbCH8sNOo
         tDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499873; x=1741104673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDJCZB9Pp6uRzDdb8U10QpXTANbtNp6AMax/hSuxDnA=;
        b=ggumyU95+kZAESt1feimjiHaLEdjn421eLVZ8coqBXnux7yQtoxRALUB/9UZNIQaX1
         U4D8Qv4jXTgPDooFDG2vGcsr1Lon9kJNhpy3HUgpM6Tky+N3gKgRPu278tIn+MNGGYRD
         +cZ3OP2gXJYw9HKOvl2uyTiPMZUvfCHVyWJW/mqNvHM9iki3qlkLMqR92oaLysX+n2QQ
         EgeUPHPTA6bWSsUd0OgEaRZ8+VIXDJm/2gRTQZX2fq0OHKi8YC3GFtJLF1TkIYaEHCpA
         HjcTgmAYznBmrf5bpZvxpa5QeY4IxlJ8bqWFMAJkoD7Fq1GWr/JwmjjrMktNnkyC00cG
         c2rA==
X-Gm-Message-State: AOJu0YyXuEwYwnY4rS5fWuDihWZUXuOk0sWeADhcuG7yk9ObA60NC1MJ
	oqQZDO7zkeejrx0E2JwEEMVeJkkfACJbgkJyd+Zp1bjfvrTtxJZQ
X-Gm-Gg: ASbGnctx/qKEW53QG2ds9EZzJcUbIH4QN0sRi1Cv5XrZWqY/4Ua1GcNWjnrYfhGssqY
	1h/rSc9vfNNQCaa6MloSxd4ALgVpXlVD3xD60Td1D4AmLEqfi/oswP0MI9hkFNuSR71TR1S5oWF
	gOjwZDIrfeCm9QTaO5+I68XN2hbVGXfA+SEBFeF5rAnOQ/EQCuSqKsSb8haGDr3fzuxZocjlP25
	XXeMiLrw3EJMi/3kM4zVP8GNSX/Me2g1Bv6k1KGkkWukx7gn6JOZiWFemu3T0BHZOp9lOVN+xls
	5aSr8LoSfkVJf4zUvkFPv+4CVuaf87jYcsTsUHYr5EoOlBraS2VerwWZxkXxpMC2xPrCdXSUxKC
	tWkTyIm3l3VquF+tS
X-Google-Smtp-Source: AGHT+IHIvgOxeF2vUrO6Id0susj4j+TlWdZrBA0+HuMl87x8rkL1oJM+QIYfbc8AAQIVSHuTbVfHAQ==
X-Received: by 2002:a05:620a:31a4:b0:7c0:ac03:91be with SMTP id af79cd13be357-7c0c21ad273mr3041271285a.15.1740499873531;
        Tue, 25 Feb 2025 08:11:13 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2992d5sm122754385a.10.2025.02.25.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:11:13 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id EFC9A1200068;
	Tue, 25 Feb 2025 11:11:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 25 Feb 2025 11:11:12 -0500
X-ME-Sender: <xms:oOu9Z_Km3sP-tMA4V-OFg-c4r6S76h9ZAJo5k533xHjycJyDRGNRPQ>
    <xme:oOu9ZzKd2Hqle2ykBcpJXsoCUgHIbK3kehhsdliS7eg0fVNZx5MDTRzsfMXmWsqX5
    p6PoLGOVlHwtS2Xbg>
X-ME-Received: <xmr:oOu9Z3sy7igXh_rNRFc_Eh8Gjf2hrWfFlrMMQ9ReilAaiWkAG7P3SYys7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:oOu9Z4ZsDedxNdY5j1_pZMyIncSqCyvTHdls-VMEob-wiw5V1mAdZA>
    <xmx:oOu9Z2ZdA-y52mopQFl3r583UyL8ssj-dw2HQsjEmRYHMBfc1l2UOw>
    <xmx:oOu9Z8AER5KSwRVTNG8xJ-xkZDA1c4_45V59pDJ7hkI1F3qHVWS_vw>
    <xmx:oOu9Z0YXH2pe9pCya8ZwG2p8OKpfM6YzakJJAVwv1pEtwL_baSTY8g>
    <xmx:oOu9Z6qZXk9S5Ppc0uqxiyHmStkfJx8N-DrHW9-k810MJLoQdr8BARPM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 11:11:12 -0500 (EST)
Date: Tue, 25 Feb 2025 08:11:11 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: Testing of shared RCU branching
Message-ID: <Z73rn9nqlCwns1IY@Mac.home>
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
 <Z73rFVTHr-etZ8SE@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73rFVTHr-etZ8SE@Mac.home>

On Tue, Feb 25, 2025 at 08:08:53AM -0800, Boqun Feng wrote:
> On Tue, Feb 25, 2025 at 07:58:01AM -0800, Paul E. McKenney wrote:
> > Hello, Boqun,
> > 
> > I have run overnight tests on your earlier branches here:
> > 
> > ccb986e8b69f ("MAINTAINERS: Update Joel's email address")
> > 

Oh and I should have let you know, I updated next and dev branch, the
latest ones are:

	next.2025.02.24a and dev.2025.02.24a in rcu repo.

Regards,
Boqun

> > These passed other than a KCSAN complaint involving
> > rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
> > This looks like the plain C-language writes to ->defer_qs_iw_pending.
> > 
> > My guess is that this is low probability, despite having happened twice,
> > and that it happens when rcu_read_unlock_special() is interrupted,
> > resulting in rcu_preempt_deferred_qs_handler() being invoked as an
> > IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
> > data races between task and handler on the same CPU.
> > 
> > Thoughts?
> > 
> 
> Do you have a KCSAN of this? Also this is not a regression, right?
> Meaning you probably have seen this before? Anyway, it should be an easy
> fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
> and put it in.
> 
> Regards,
> Boqun
> 
> > 							Thanx, Paul
