Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7E1CD15
	for <rcu@vger.kernel.org>; Mon, 13 May 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618312; cv=none; b=HSEL2/dxDFmzIyMhiTWM5A3EVErMrb2tLdPxp3WULR4muT+Okn8/o2Ok9wFsFut/cgu2MyySfuabcDC5RFGZ/zIS/fydupM3oqmSZk9/tl/j1QESJQusVnWzl8T5mpghQYYEdgRbKG3u2lteV/4sEJMgcjYuD7OBuleS76uj5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618312; c=relaxed/simple;
	bh=Ovx1j7MTjRL6Gty0o2yuKfyr21Xg0c7KZt7RCfRDmCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSeA3DHIS+QogQiNKkQzLTA4rbQ/4lEc2je35tlF6tz92lsVW1ZkoWj0ayLljCRcv6Gxk2PYsAXqOjHp22X0ZDOcWGBB0RL+HRtXEYd7KEyLMqQMUiUms56x7zEczRXKvMaESxRmX3oS+usGccIPeHwu/ludIKHHRXF5/sRrcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lo7qVFB+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lo7qVFB+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51ef64d051bso5260107e87.1
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715618309; x=1716223109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1Wlf37+51HtjLRgNKMisfOzo70QDhMnfjuuCuIiDuk=;
        b=Lo7qVFB+Jh7cpluQxnVMhaHCsj4WRipGnXSE1xtSvVEKXYIpx6lwZQ1L53APFYjH+p
         au4MlXXjUekXGYIYnX1+3i5LWt+5fZSmovvUW4GBLyXX3Vj5M7wzMtsyZ+mw+3bdTRpN
         tOTuGUpHgf9IZllzgvDR833VM2lv9FejDdOEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618309; x=1716223109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1Wlf37+51HtjLRgNKMisfOzo70QDhMnfjuuCuIiDuk=;
        b=TPO8LeUhu9FnIhGYijI5ie6rtsXLe7PzvHvq+M5lI8xC/tjGkPpJwlDMH30g9zaxJ1
         EEaFkJA83xTtf92xqlkhcFjxUpvHFU1n3owp2jK5KXkFR87frh/p5XC0GkMN/wiijmAD
         8efMDgDPHyrr268rbdQdtpau8b6eGuGrS5xzFvOaYS1EWxdSrlplqZjEjgZ7gmqxQf2r
         RiCdRGNFhaHddMNjIDYDMM4SKV3HbYbflcue9YyUKaOKtCLLbt9mP/8oY8gv0pE7Mfzw
         GmEWTOVXshOG/TEq5HkO1jbGymfLKRfYBHulpw7s/mnMq/GU7Ryzr2W8qzVk+0U8ZDgA
         XEaw==
X-Gm-Message-State: AOJu0Yys90bCSwOH5NuCizIrM40DM2ZSg+G2qN4b12NnukMqBot46ZNZ
	W5yQoJCWqwXIdjiSLnJO/oPUyn/kGi5AZVj2AON1x9mwfXDwtBH6WXardNnhPOgR1wd4GMmlgow
	Tnmo=
X-Google-Smtp-Source: AGHT+IEPAcCpN47DPgBqID1bkMx7u3zTIAfkICl36XBmO2MII/xuknv0Obra62V5C9dj9XF94TzyDA==
X-Received: by 2002:a05:6512:39c3:b0:51d:96be:b50 with SMTP id 2adb3069b0e04-5220fb7761amr7763699e87.31.1715618308726;
        Mon, 13 May 2024 09:38:28 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17cc5sm610774566b.205.2024.05.13.09.38.28
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:38:28 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so1138069166b.0
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 09:38:28 -0700 (PDT)
X-Received: by 2002:a17:906:f6da:b0:a59:a97b:5aff with SMTP id
 a640c23a62f3a-a5a2d680c8fmr687211266b.73.1715618307800; Mon, 13 May 2024
 09:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510183049.312477-1-urezki@gmail.com>
In-Reply-To: <20240510183049.312477-1-urezki@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:38:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
Message-ID: <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes.berg@intel.com>, 
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"

[ I should have reacted to this earlier, but I just put all the "for
6.10" pull requests in the queue without looking closer ]

On Fri, 10 May 2024 at 11:30, Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
>
> Please pull the latest RCU git tree from:
>
> https://github.com/urezki/linux.git tags/rcu.next.v6.10

Hmm. I don't have your pgp key to check, but I do see that it's in the
kernel.org repo of pgp keys so I know where to get it.

HOWEVER - importantly - I also don't find any handoff emails from Paul
or Boqun giving a heads up that I should expect pull requests from
others.

Put another way: I really want to see proper heads-up and "yes, this
was all intentional, nothing odd going on" when seeing pull requests
from new people to core areas.

              Linus
