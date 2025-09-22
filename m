Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21B1D5AD4
	for <rcu@vger.kernel.org>; Mon, 22 Sep 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551436; cv=none; b=q+4kVGVdh2Zc+aRJ0MJyp8hmwtsyhocmdvP5s0ByHJBuzeoIVft2qhhFW1paAzR/qjv0ndByLMXXuQC0CGUsB0sH6aWaFBaSXPsDz1XECZ3Q6miMrNS1qH4Q0Vr0BjmlmIj7KLysp3PWqL+eN65upNKTgY6+37ftia1qVZUwBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551436; c=relaxed/simple;
	bh=eiNsGceEGVlgJiEkBCDzw9gODtxe4yqUjFX20CRK3r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lldnFm9GIoWf5nQAVPK48mmnNjMHMtjMLMMCD0se/miJgYkEwoaLTqulLVN3PbRjqQ976mb9Z/9vu+GpRHhsupLrwlKcJ7SpbCKXapL6OLSD4f3ud+3/jhuVRyqCfJv39cPEPFrRI2xMOzG+FNtO5nIr5zhEavXq1Q3O1kG1fVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D/dME9wQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/dME9wQ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57cfe6656dcso1485658e87.1
        for <rcu@vger.kernel.org>; Mon, 22 Sep 2025 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758551432; x=1759156232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiNsGceEGVlgJiEkBCDzw9gODtxe4yqUjFX20CRK3r0=;
        b=D/dME9wQbi7L9KFtGxo5qFhFE6pqH7pi9/i5EudwtbFZ8DnGxXZhv2Y96zAZbCe55R
         qgHHHerWXNO3Jw2daUcsYsDrqPvj5Ghn795yPlsHlKM1ylQvDLFd0RUsocn0CR9TQA0e
         PHgCGwmZ0lVSca8eti8Fmq/vOAnKF6D8jujMUVnSk0BdPzwG75yStZ8ndqDmdVH/DrLr
         ZRw5Ja/XXF0RBbjcsBZItXWgIPp2gDFoJZWHzbFh7ifsZS+oV3mZ5qeO9hb2rIe3cVil
         yiO08ktGCH3eUeHL/mgfBwO9Jvv5VW1+mLHxIYbK/66JTCrA8y/qM33mgC3DKnNhf/Fu
         3M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551432; x=1759156232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiNsGceEGVlgJiEkBCDzw9gODtxe4yqUjFX20CRK3r0=;
        b=dKgaJgLJnrcvmove+0Ys6EaUcKA+A3FTyirkvALoNSw085etQ7ENzTXHQHAprpEXu8
         awtr52kiExyMgs9bgzrkXx3FLmM5P0uPXPjTtk0LYrISPkQEntUN2e7NjXLSBxnbnmyv
         GpOa1uguJTXccWszc3GXEQDMyLDWtwk0CsWjerAwa0JHlqIvNdjdMjIrDAyIwk7dqHjT
         t1ttFy7OzQs5/QDh9c1YVNQ/Rm3/+olZwNH5haMAQOTxueoZMf3UonNoeb4N5AjkLsx0
         ycO1iekmfkJvSnZlOJ78C7f862Tr2iYDEiqgAoBk4fcdcQOKIk3IpmC4M8bhFu2HOC4G
         ZTPA==
X-Forwarded-Encrypted: i=1; AJvYcCX29Cu85k8PMx9vhFX/ye45ONBWh1D6/F9JyTBdukzHGJMBq7r8ovOKHWOhID3sDZoDDYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4M8dDU4D2lypE1LvdA4pzAe/iiIJFkPJj9GDeYZCdyqCYtDMz
	3m9y7uMWb6fnVGA20ogawNM3iJrpNbDr0eCnjVWCq8qo4EIr6wtgasDvYIP0kemFa+unJGNjBmp
	8P1ffZrKK1Hq7SmUJSnlj38dFY4Tvs3mv1PUNURkijw==
X-Gm-Gg: ASbGnctOLojzHXtIXfielb5bW3RQ5wxV80Q5G4UJ4LiTSVk6HVP1Ocm+ep4GJ/suoAU
	AQVSvEfVNfLDx20otyXBYfboL05EGScTVuiQHxWjvibN/7ejnJYMJQuCUNeuTLPsQiYP/AspAyx
	UcFmbrwJKGPWr7UfVJWbTDqpW7BRlwt5M15RUlKFLH6MRoURkId5eBSvZT3zUt4D3cSLxxbZRgb
	U78dSq5i2EXxACze5RzD9uwOFul9SzR+B7Gztrw
X-Google-Smtp-Source: AGHT+IHnljy6MP1njBU2u6c+KrnvxWSTFUDgkOJM540hMZjQHZVDbhSTXqE4U0kGHkmVjewhciQ3zOA1yfPO/vG96Fo=
X-Received: by 2002:a05:6512:12c6:b0:572:f47:d10e with SMTP id
 2adb3069b0e04-579df8cede4mr4364273e87.3.1758551432236; Mon, 22 Sep 2025
 07:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145040.290214-1-marco.crivellari@suse.com>
 <20250919145040.290214-4-marco.crivellari@suse.com> <aNFZ1huhgmMkaIWH@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
 <a2b31164-2175-4fa5-b003-c0be8301bc9a@paulmck-laptop>
In-Reply-To: <a2b31164-2175-4fa5-b003-c0be8301bc9a@paulmck-laptop>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 22 Sep 2025 16:30:21 +0200
X-Gm-Features: AS18NWBzdelpp73CqEkT85EM-0gvDu1qtbxRp7JXunoUtqCYIa9fidb3-H7hIxs
Message-ID: <CAAofZF7DURjSwN3sRMDd44eq2d7zgDBSHtnY-UdXaG7pQac06g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rcu: WQ_UNBOUND added to sync_wq workqueue
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:27=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> Applied, thank you both!
>
> I will push these out on my next rebase.

Many thanks, Paul!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
