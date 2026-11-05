Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843805;
	b=3nxv8zQUvp/NU5sdQl0/tyzQz0rF9KtjOM5ynxByxPwTtj56QkAxVzDsoWmoAiYgnzP0
	 wEM4BqVc6gl5DDHWlJ3dyw9q+erGb8/lx2h2UMStPeTP4NrfKwM1dIZ4dXU3DhN+RD/YQ
	 P2qihX3tDVNfs1PSdWAQfsx0d0+EP4LNmC6gSCPjhtf6tDuk2a1Ek27ijXJEAmkV/KBC7
	 b6LUXotkQmLz/jc3Z8KFsUZjyr8W0X09ZA40dev/8KRw7Fq/JNXKIfBOdJpQCXec2RL6Z
	 4Z4qYVu5nc1Fk/rfa9Nerpnx5UjxDlMEfOuh3uUwh6EFVimmPpDFBh1g9FvG83dTdGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
	b=YbM990EwvXg6V8QYVMZrjkPN1/My7sGCljsBreCKIU4ENKTMSNVlh12D5p7J922lmEWn
	 1Fq0+wVLBucfd5rWv1lV8iXxR86SariJe+hYG9aokaFb+2FJDFiQdbOEwvBEIqWpX/re1
	 ym02eJOBZMj+KBbGNmdgJwhRx5yYcCkw2dfIdeOe3RIOGi7jA3y9i8e1BXVGw6F73ObQn
	 uNpzxFKOfT5J0kAMCiQtcgzKyziwlSLM7ug+MpFP+Vbv0sB5bCpYHuBs7ClXc5cUAhrmi
	 Kcm1oF93qlcNOqTFb7xVZbG9mog4BNJ7+kHK6EO4M0BGMF0FKqo9CE/5DXDMhmze3bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sg8D0+ka;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B47606A31B
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 01:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B47606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sg8D0+ka
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a1947498bso3503432eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793843804; x=1794448604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
        b=sg8D0+kaPPpUPvH8Fa+Cei6LuqtopYyEBflLw3ALL3zHuxcJ3l8hfMCApuoapYXBko
         C/4oNFNo6KunjH84xv1nEH5swz/YXSUqyAE/18jbK7uIBFx9Wbkr6CX19BBTKpIecfTw
         DXdOlE8s6O0cMfxjg8oR3F7Bzgn4jIpU0UddZzrW8ZqQYjM1Juqlukl4flzFiphzTW4/
         +gQ6gkEIv1j/FMSkkYJUkIg/XnUsK3tSHswyNm+RETHwHP4yzcCNF34ubVo6zHzrUwdi
         5tchKAr4KUpYBIW6UOoFhVKJXAkf+wbf+v/DWJ3qpYFu2T31EAO7+4jmprAzZLSN9Njw
         Plyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793843804; x=1794448604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
        b=tXfdmBm0iZL9WRA/JcATFj9ebZgcEg4p/PSCnIVbg15Xh6FZ5iJ1gFoC7yJaQ0g0Qg
         7eQFrTxZH/mohwUJb5i34YDrqwVHvqara/qgNxqJhPNMrxqHKOtZUTtSp2yZgxlvfBhm
         XjIaWam8gGtv9J4R5mU3uGEwT52cW2z/or090Z+9poNZVuVrYmXDvZyH1DX44J0AjsEx
         9ycjdbWjU1YHB+XT9bEf2gdm0SUAsKilmhb7q29+isE21KI92l5dKTFs9Aas346JpJwx
         /eB+eIomKqUiIMmiVArmdiFPBmud6LxM9S1S1U3/UVdeNGyil9NzdyNnTBXvtR52qZwo
         jaDA==
X-Forwarded-Encrypted: i=1; AKwUvBzmoy1mhFqbC7KWUxrwjkMxbnxbGwROMXYVmqW3GMoSYmiP2qkeeNtoAh97RYJc4wnMe1U=@vger.kernel.org
X-Gm-Message-State: APuU4Z//TeO0O93DfvxniRgIL9RAkX8O1Kd4uX6FpvU/XSoetfj+BV7t
	8ZBFITXnckDqbRR08WtAx1jgJFyoueUmWhO76kPfK6J2NlkzaGfJbIL1
X-Gm-Gg: AYBFou3NcMN1fbN2En+aicy66zURq4iaftXIWcpzyfP2GsjAQiC42Zn6EyBL992DgTp
	ilTOtvzneG+keJ7TfkPXdC2FYRJ9IxTv6TX7s4co9eN50IKmMX+j3OdQFosk7lL8UReCz8D+JAy
	yz8WN5Fnof5YjvK8GGl9ErGn7p5mqgbxgW/Zg42k24hiYpARXULha1HK+aTkc/xGb5ViviSHMks
	C7HG9wSfpuaF8B5h9atNX+drou+qjQZX2PTaREOjKetZ9ZsMp0hte0fzsvsJArOWffwo6uLiZBL
	Q97kDdYCOrWoIGV2F+VYQs4rNNiemsAkxRW2Yfc3Y2tvH0yodlaa0u+EklJM84/Y35f7JZ+6fPZ
	CE90TDMYfGsIb2Kw8Gi2E1wocqAFstV5MZUbjXLHnIQaS+7oP4UkmbLxV3ktxx/ebHbKzOzgjwd
	nmL0f2X98nQ6qFO5ZNTtW7hU33VNYr/BdEnguHVM671di1jGhIeq6bS6Npb2aZ9D4jmA0jg4Ey5
	rNuqonevJgkZlvR9spsN2oeyZoTqxCLd0/at9wx8LGAW1IyFTY6+Fl6WVmjQrL5hDNLHq66n+nC
	W/ALmdP1Uoj49g2qtF9k
X-Received: by 2002:a05:7301:2a05:b0:36c:b138:651e with SMTP id 5a478bee46e88-36cb1386818mr7686510eec.22.1793843804409;
        Wed, 04 Nov 2026 17:56:44 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm16872570eec.3.2026.11.04.17.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:56:43 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Date: Wed,  4 Nov 2026 20:56:38 -0500
Message-ID: <20261105015638.746024-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop> <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 05:46:45PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 04, 2026 at 09:14:13AM -0800, Paul E. McKenney wrote:
> > I am not inalterably opposed to adding a list_splice_init_srcu(),
> > especially if quite a few more users show up, but here is what I was
> > expecting people to do:
> >
> > 	static void synchronize_my_srcu(void)
> > 	{
> > 		synchronize_srcu(&my_srcu);
> > 	}
> >
> > 	...
> >
> > 	list_splice_init_rcu(l, h, synchronize_my_srcu);
> >
> > We need at least six uses of the above idiom to break even on the line
> > of code required for introducing a list_splice_init_srcu().
>
> Given Qiliang's response:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks, Paul.

Christoph, with that, please disregard my suggestion to take v1
instead; v2 is the one to apply.

Thanks,
Qiliang
