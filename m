Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69F1CF8B
	for <rcu@vger.kernel.org>; Mon, 13 May 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619537; cv=none; b=Xlomnk7uDEfjZPMIBz/JpsHB7swGicQDcNLXrA2v4dGBgVgyKYS8LGqp2uUyqTzi7QXc8UwhIYlnxr0beRtS0GanBEFPAiMG1xsMrZJHQni8+qlrpcw0X8lzPNDzLoAVIMB3Giz1dEEt4nfdL0unzjLSmcC2i0+Eo7NMSvX4xhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619537; c=relaxed/simple;
	bh=PlOzRXdyKOyYci4EvE5Oec3vI5kKVFNipMrg3GxS1yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7b3S0ulGIkEHD6HX1L8TlIverJwpcpdy25xuu5R5cgIMVLD5oodykJFQpdnXVVnxOSQD8ZsTiqzjch0ePPRQCVeMuhS2hOwb9ODVutm+BoiaR7e8BSvoltrJeM/IIeZcHa+Gl4THHSxBHwxJXXw3kwVWlea/gn2j/vg2QmHrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PhaTc6Be; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PhaTc6Be"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e6792ea67dso34728961fa.3
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715619533; x=1716224333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QIPkiYhi3hX3pVYh4/Y1KE+AEhpcFZd9Zg9lkKUtFLc=;
        b=PhaTc6BeEE5iSdDCdFAj+UKZJXbqU0WB5bBxx0yX4xg8cYS8SVBmJknTyPcJrL9R6f
         lCjMTOuaLxFXscvxBc3Yqqc7xNz43khmjiM7q7Vp4HXx86foX7t9hj6a70Vs2Dg6VcPl
         xpLFWezzwmtD0RsQwqS8X5kmpcPW/g5+a/ayo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619533; x=1716224333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIPkiYhi3hX3pVYh4/Y1KE+AEhpcFZd9Zg9lkKUtFLc=;
        b=sdouVHObBZWf1S19nPvWFBbmt0dKsXxvfHOuIthAuLGe1FPNcoaYdrm5H7D6aYkWjx
         ZZri3aQMqGCkfJn52y93Li9OyI+yps1NwvWJKTuC+8QFFvGQiVsje2GtS9Mcsh4h88cT
         OnwIu7p+4LY2LFwZKZy/+MNHKnAHY62Cj3yHp8vdqREJl5dPj8kPpXJr297knbd3NdnN
         tuYPx3BoSwQMw4W7Qz4nYZzI/4FYvd5EKMAGUn6zQjnLJHhhfJ6VOom3d1lFOXY3Bg8+
         rToi6v/mcj4aW5gdoC9C6WgJWmw4ZzG470MZsV277vA4bvEa+a/7xMI0E8spTVSq1d6I
         PDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW08GazasjwcTlBlGebxJUr+YuBJ27x8dIjFh0nwcHJcNvuTbP7ck1jVtNech6Nsml2c/iKDWNfWL6zi8ruKIO5c5Mp
X-Gm-Message-State: AOJu0Yxs8Om8tNrXxsaT1ph3XE/cg7nsoR3egpZ5nVfrZZ6MfByrCYYP
	cDDPkNJOp6Qw7a210RBGX4UrTXDrViWZHZc7SlMMq5TeklmaO3oiN3hoc44RADNtBgDm4EJCu7W
	YPpOvkw==
X-Google-Smtp-Source: AGHT+IEJus1IIAavXtBpGhOCAxCF1v/HjPA6Mr0W9v4t05muaK5PwKYrJyx9W/BM+8fZrsbKhFuJfA==
X-Received: by 2002:a2e:681a:0:b0:2e5:67a7:e449 with SMTP id 38308e7fff4ca-2e567a7e8b4mr62785581fa.6.1715619531154;
        Mon, 13 May 2024 09:58:51 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce3241sm14709541fa.39.2024.05.13.09.58.50
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:58:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so7937956e87.1
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 09:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAdYOYMrVldxobdXAkBTDh7eI4/OAE4l0DFeHpCvB9tQJny5oWb0sR+IsnBDGLUkOgFKyyaSxWcEkk5skRVhdzVn/x
X-Received: by 2002:a05:6512:3b84:b0:51d:8842:f0b8 with SMTP id
 2adb3069b0e04-5220fc7c5bdmr12023924e87.13.1715619530170; Mon, 13 May 2024
 09:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510183049.312477-1-urezki@gmail.com> <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
 <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop> <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>
 <925ad012-ba28-48dc-8498-1721954e902e@paulmck-laptop>
In-Reply-To: <925ad012-ba28-48dc-8498-1721954e902e@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:58:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuwC==XgEvcP_vrFrrAoKAOwJXKavr94Gk1tdShFh9eA@mail.gmail.com>
Message-ID: <CAHk-=wiuwC==XgEvcP_vrFrrAoKAOwJXKavr94Gk1tdShFh9eA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
To: paulmck@kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes.berg@intel.com>, 
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 09:56, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Unless you tell me you want it sooner, we will sending this into the
> v6.11 merge window.

No hurry, just as long as it gets done at some point. Uladzislau is in
my keychain now, so this no longer triggers big warning messages in my
scripts..

                 Linus
