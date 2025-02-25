Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37C2EB02
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499738; cv=none; b=UDHr+d7Nv//pyCh5sTM/m73y8PHnI1cVPvAFO81Y0wv6BQ1X3ruYR2zhZQ61heq65XAxy0tMSTamTOTHD1P+UkPINZuhW8E9v25UMaEn2sf5Dh5BPWppV36ApIGYcxfmlr54xq56wy/t7Io5ldvoG+WH5ALMSxBxfnK8txUKoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499738; c=relaxed/simple;
	bh=Ff+nL+p0+Lhs5oQGWxJzWRQp/9tVZP2vppSkBCeKIGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he8mBMSPezMPJc5sWj/21zHRLUGELNAnDVO+Cs3uYA6OG93MnPhbCnL2V8d+ku6Hzyvar6BKacDuGU+p8POUjsJsvZeZHhaqi6+My1/3b36YFPJP5xabtzqB09u9ER4gC2/rOSx5ohvFuPFZFkkv81BUkjEQEW909Eq0dbb5ffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvLM2uGV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvLM2uGV"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e44fda56e3so55736456d6.1
        for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 08:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740499736; x=1741104536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RiNzBiGHUK7u8XHMonHy/ysxcLaQ+V3qHeRQuRaJAc=;
        b=VvLM2uGVw1Mv5oMygh7WRq7u9FyErGvXU7zcr8ew1hJ/6ZIKANDVsLpSCu+DQIWsd6
         effp+p8MSkSy8VSu0IMvYbXNlRTeGoGj2hVZq78WCn+F3DLBDWRvkvMFFlIZ4BUIrCbn
         9OwgSwSLLWMO2UVFQFOa7cfnDzKIeVCIoTEgLuzvV1AHC8AXH4V1CRuAPJVDRuxmcTSp
         VAs+feG0LegWoXkUtimueWiOkZJGS6SIuM8LJK1zYRR7wDj1i1tLgaOlSuttVwIdQmAa
         7HSFNRZk11csXlgKnWOTVUCrq0LzFtQS8pngT1tedqQjsiM4y0/N8w66tb3yYvT2Ln41
         UTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499736; x=1741104536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RiNzBiGHUK7u8XHMonHy/ysxcLaQ+V3qHeRQuRaJAc=;
        b=njXcbi3eSvAWGhl5Fzeu2NxsLON8mgkAD4PHlzqN/frSeFKoNZd+B/7wpvF4+4g4rF
         fQ2TzxemVnRfDnnuZdmYSV2kf2mveWeEDEpn37Wd030ybcxNh/Id0y27+GhddvObyndw
         vi/Yn7IaDdZ2Qx2WShM3GLa+dW/UjKLJQUJz1+kLWFX9uOLl7efwuCHYh6VYyw8oJU4a
         x7TOgxokfwBoWNeIzGvnQvgA5BmXMM4jpiP9Z5hdOYDN1J5A9e7skG+1LTehGqIYJgXF
         OSOP0PXD2ykeQL6FqeWgAXF6nUIGU+S3xPGcDU/iLMQjlDgzHiqU525ccHVDNWV/ZuD7
         STgw==
X-Gm-Message-State: AOJu0YxTuuBsKlS9x1iClmNFiKVXBLEMq2Iv4L5XUsMY8Jww9ldl/nSd
	Oxtpu2FwbHkWlVxdIjgcydV19N3rBEU/MTARA57cM8BH9sh5/TNW
X-Gm-Gg: ASbGnct7e/tPfKWwjGiX88+PLYfcb7Gi1NvDnXWjy93jWqwz/bnaLFVF2a1hR3u9I8M
	aByJ0RlvM8MRT3+gsd8IhBaQM70v86G4DOBbm07XkGevU9JNWn89GcdmdgHrDWADyv8B1BPwK8L
	WwDckCb9uJCvIITUbueiYvN6bT/ca0ZBr+gETSbPtNohza00GqCzVJEdtG32WTeE5oFsiLFI1Z2
	AeikwxV1xpBznvyjAIBQblhyAED8F2MMl3GT/jmMQWChaXLgul4A7qoQ9imj3W7IsAQm1Yv2mgD
	PB+HjSV531xjENffL46VWrvFPodjxHdd1ofJHGuzlJ6EW+FJPEBVf0ZIO4jsZqfepl9yF777Wye
	SmJtYdjTWouYZQJu1
X-Google-Smtp-Source: AGHT+IHjsSYQYGWS9DHsk3CQJaK2wuygHGFwrsyg9v03sqtaHWWks1E9KZM82WuqRjnVWW9rC0cveQ==
X-Received: by 2002:a05:6214:f6f:b0:6e4:540b:5352 with SMTP id 6a1803df08f44-6e6a26399f9mr254476586d6.16.1740499735604;
        Tue, 25 Feb 2025 08:08:55 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b086e3esm10756866d6.31.2025.02.25.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:08:55 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA84B1200066;
	Tue, 25 Feb 2025 11:08:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 25 Feb 2025 11:08:54 -0500
X-ME-Sender: <xms:Fuu9Z6OL9DRDNNqxbYX84sV-pRv_BlSsAzRibDxStbdqFu9HmZCxUw>
    <xme:Fuu9Z48Czp2b-14DiIiR2wlCvSXta82bgaUmIBN5XkU3FbmB4OWFiC2QjkGF_Wd1l
    rCsOT_Dwh0X-HHWKA>
X-ME-Received: <xmr:Fuu9ZxTpN5yhXcGcnL8X4yBR5u_YOuFicQ3y0x8bHruBoGY5xI-fML7kYA>
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
X-ME-Proxy: <xmx:Fuu9Z6uhiTqNrDeFFsdFHfUN547SGqDq8gyHb6cSIVy-04FK5O5wxg>
    <xmx:Fuu9Zyc8wSPjZcdXVzMtfETtHJsdUlE_OfTFsHQPxZTpWEpRkKEa3A>
    <xmx:Fuu9Z-1CLJyCRZKUnn4TrccMpIM0knU2Qh9cbgJGkFW5jXJF27756w>
    <xmx:Fuu9Z2_-Eu4PBB2HmhAckLywY2rrnFRvVaHHpAhhSDUOcDTKVPPMMA>
    <xmx:Fuu9Zx_cskezchBATXAsVM0z2UV0W4_p7IR5GjJmCSSI-FYR2WRaxz8Y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 11:08:54 -0500 (EST)
Date: Tue, 25 Feb 2025 08:08:53 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: Testing of shared RCU branching
Message-ID: <Z73rFVTHr-etZ8SE@Mac.home>
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>

On Tue, Feb 25, 2025 at 07:58:01AM -0800, Paul E. McKenney wrote:
> Hello, Boqun,
> 
> I have run overnight tests on your earlier branches here:
> 
> ccb986e8b69f ("MAINTAINERS: Update Joel's email address")
> 
> These passed other than a KCSAN complaint involving
> rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
> This looks like the plain C-language writes to ->defer_qs_iw_pending.
> 
> My guess is that this is low probability, despite having happened twice,
> and that it happens when rcu_read_unlock_special() is interrupted,
> resulting in rcu_preempt_deferred_qs_handler() being invoked as an
> IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
> data races between task and handler on the same CPU.
> 
> Thoughts?
> 

Do you have a KCSAN of this? Also this is not a regression, right?
Meaning you probably have seen this before? Anyway, it should be an easy
fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
and put it in.

Regards,
Boqun

> 							Thanx, Paul
