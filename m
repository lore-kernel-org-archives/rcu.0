Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F718E36C;
	Thu, 19 Sep 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729020; cv=none; b=rRi/QGxecFNTQuW/oI3z04uAdAq7W6wlticX4m9XgYnyEOcReLulmy0OE/ZXvYpmIdKZP1vGtXcNHW7PBPmxx/sOV3q/5PyDVUChdwg+YeVgD/ieNO0xoiRFg+50gaOo9IQSkLnjorkM+2x+IL5rQsLM23x+ZY21Ms+InsPdtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729020; c=relaxed/simple;
	bh=GfMtiwPE+51iEN55DmgtKun5udcA+FmpKBvyQAJtiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFrTV/3zQ9qj7gKyRz9zLYVRnWdOgu0fIZB5URddHB2igzOXPUF++AzevhJ+DLT3+fbPPleG28y/+HzZaqqXUylFJVfZZ22/iPxTzjpOMLpJlUkeVLLpugFZnhKmk/fg4J4VjLiUSn0vNO0CcUvKWqlvHCHs8GNyriCWT4YStCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNpi5FaN; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNpi5FaN"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-49bcfbc732eso172157137.3;
        Wed, 18 Sep 2024 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726729018; x=1727333818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjyqInDSlrYo8BNK/yoqNN/E2zQvq1ceUZAN9Ivf1Ww=;
        b=bNpi5FaNaeVbaemka+wdBKONz7KbTG9DHRjA9nCZ9vWWzHXTX9CjJefEtYo4vmKbRt
         zGP2cyxdnd4/qTg0D+mii0wAURP1zKGcnNyubKC9V+cSwNTbBIPCO0qo1olOECosQ0KH
         cgaZp+itLL1czeDahXRTG+MBoH7/QLZqRkh+oHnxyKlfX3g46sJX5aGjj56g6jh4Kjin
         AL1Ui1wKnznFdC5uGHegG6c3FfJzOswKqshdZdTkqDWa1EtWFz3aoS5EWsp/8UAEfC7y
         RhdNbzwgKLiNYvr33oEUr3KUqNZdo3IYCVD70LufxA/A8yqTLBQKF7bD/nfci37I89HS
         nMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726729018; x=1727333818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjyqInDSlrYo8BNK/yoqNN/E2zQvq1ceUZAN9Ivf1Ww=;
        b=F/sez8UpMFeckcaFIytuE7+UjjRO85okpo1tgmtFvk03SpA3LzLYiwBqt2rmS5Xbqf
         BUo8do5y/qldAQYZl14I4LW7GdMxRmGjvdzmwlCaZgCrFcZLdIVe28CTxKg2GoDcgWPU
         xz9X4EpToQ/kZjjhuNn9n1Ji+JoYUII+QAeatXSiD7KlG2i3Qlw258hPqGk9vmKjsDJz
         DgyaMQzGpiSFqmRDGFd4DcplQR+laqNhqmvCb9hQEmBrOiNUP103jic67chtaAxP51hj
         ele6xhIa6T2v8v/JHVyH8VBD7lGm/fcr92dOwz6tjdL1z+YZlOVihhDPq43pL/A8FaTS
         r9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXExlqm20WfKcwpl+PiIcJTeGdV9XP0yDcpn0UQ3JkNatbl/LLgEeGL9ZF97pkm345W/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhPIcv6KNbj00YK0QpenoNdfO2Pns+F4IoMeKmIbZWdPuW9z4
	/Y7rgA+q8B/wqyvqU87LEz2krIQf5GMi4C04pwUqG9AHUbYYi/Xe
X-Google-Smtp-Source: AGHT+IGC2ng+ioGsscrlsntuIBMM5WTvaUWY7204GDLi7nIUdEs4TTLE54L89LjhuWEcoax5U440Bg==
X-Received: by 2002:a05:6102:3a0e:b0:49b:f52d:4922 with SMTP id ada2fe7eead31-49d4f6f4a03mr14575335137.27.1726729017873;
        Wed, 18 Sep 2024 23:56:57 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e494ac0sm4288096d6.66.2024.09.18.23.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 23:56:57 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id A0B96120006C;
	Thu, 19 Sep 2024 02:56:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Sep 2024 02:56:56 -0400
X-ME-Sender: <xms:OMvrZsjQuzR8LjcH1fyxPi4DCGk_4aGdtcfdQb2dcEEe3JmUjiewhw>
    <xme:OMvrZlCx4WE572S8TNm0gmi5axMT2XV-YSkW-GBe8ilUU14VK3ZLbdw90B9oj39Dl
    aH7m3SZO-xn8-XMiw>
X-ME-Received: <xmr:OMvrZkG3hj_ipRls2R8vHpeTQKV548Mtgq74FH6jYxO5x4XBL4Qif90Qna4P7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeltddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhmphhgohhurhhiuggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlkhhmmhes
    lhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehprghulhhmtghksehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:OMvrZtTYz6eTeNpSPaGUUnR0mZ27PrY_kxLNod_4kdp1GIndii5Alw>
    <xmx:OMvrZpyOASirtdrlWDwgjkutllJxiyOOUPRmSe5y0joX5m3wS-I3EA>
    <xmx:OMvrZr58gK9PZZmQ3W9-QIsyvB_iWjo0RV0XKTqhQZzKygh1Cy_ZdA>
    <xmx:OMvrZmxijV_v_TYpb5r0TV-G7mOrhjbwTfMYMIS2LoznL82NeV7ayA>
    <xmx:OMvrZti84CHJOGT8SKPcpSSsg7YzO9X45gid7lVgfGx-NoNwR1RUw37b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Sep 2024 02:56:55 -0400 (EDT)
Date: Wed, 18 Sep 2024 23:56:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alan Huang <mmpgouride@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
	linux-mm@kvack.org, lkmm@lists.linux.dev,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Neeraj upadhyay <neeraj.upadhyay@amd.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
Message-ID: <ZuvLHxH33-p8ki1d@boqun-archlinux>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <CA757E86-2AE4-4077-A07A-679E3BFDBC34@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA757E86-2AE4-4077-A07A-679E3BFDBC34@gmail.com>

On Wed, Sep 18, 2024 at 11:17:37PM +0800, Alan Huang wrote:
[...]
> > +#define hazptr_tryprotect(hzp, gp, field) (typeof(gp))__hazptr_tryprotect(hzp, (void **)&(gp), offsetof(typeof(*gp), field))
> > +#define hazptr_protect(hzp, gp, field) ({ \
> > + typeof(gp) ___p; \
> > + \
> > + ___p = hazptr_tryprotect(hzp, gp, field); \
> > + BUG_ON(!___p); \
> 
> hazptr_tryprotect might return NULL, do you need a loop here?
> 

Thanks for the review. It's me who didn't do a good job here on the
documentation. hazptr_protect() is supposed to use for the case where
readers know the gp won't change.

Regards,
Boqun

> > + ___p; \
> > +})
> > +
