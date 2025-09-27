Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486136D
	for <rcu@vger.kernel.org>; Sat, 27 Sep 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931533; cv=none; b=DujyP95+HWHIsmY2gLsBNYcMsWfgYcZ25UhLheQBZ4MgmMqj3vq/88aBee5m65t9zOKRnkeX55+bilp5N/Vok+5CmepTkjy+foyL1Po1d2IzzmQmTm5fsgp3XUS5ENapZn8MAOpU/MQHI7zbsPtP5sUrdUxrJsHpjavvS9+jQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931533; c=relaxed/simple;
	bh=ZJcApcxweyRM5qb8q+BHO4zpFu1pgF/83cKbiJmqjlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVqB751YuaTvfKSeFtuL8ZqizyUn9PFmI3PfIR7f3chmE/ovsZe8wRnQJPAJGTPtUocUdwcJ/hn6ftsfoTtRAdeNG3KbdR9mw2VTIcz+EQYwJuXX6p/WtX0JzJpiHiMzmN12Z0DQBIXHD3/x6xoqm58yS2HmLt9iBe82rTK68u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFlx1ZGR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFlx1ZGR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4de66881569so146821cf.0
        for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758931530; x=1759536330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJcApcxweyRM5qb8q+BHO4zpFu1pgF/83cKbiJmqjlQ=;
        b=fFlx1ZGRN+qUhK444KwnVs3liZNlfzpW1exholcT2nR0AYh2NWoP52OvirEWgRgw2b
         r2y7Z9cTqcVN9tykd1OguhlcO8/THgvhFc+A4m5mUyfF8jzlBPsajCxdvuloDaWaAGJz
         yP8E74IwU8wVov0QAOONU8QFJuexgsQJNrXBTn4KkSy0h7+w6pjKCPLDjGpDtv8wLucl
         LJ9ZViLNS2Fr+Bj1u9wF+vgLuP/r3Hr0i8wCefX2ABS1+bFZjwBJ56BHp/FfiT08kR7X
         KyXBP4wnTsjZ8UtREdB38Fuu08Ub1p++ov7CCi7RTAiyr19waB4eAaC0l02hqiCkZpex
         AD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931530; x=1759536330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJcApcxweyRM5qb8q+BHO4zpFu1pgF/83cKbiJmqjlQ=;
        b=NTof1UwGkqC5bAZY5OUQj4B5/4l3oIJkYFl/JAxkn6Z+0TiLxbYpJ0JMa2IwdvBZyT
         5yCccPJbEgOOGYNC6o0XiRN6uJUpwU92i4sN0GQTmz6QHNI5iA/woSG1Q2RhFfNry84w
         4sZBE78v3SuP9fbwRA8D8lAfHIf6cAlkglEjmp3V5rk71pnVEAM5PZahP551T1ByUtba
         CIaD4nYUNcchj4u4MX6rLml8LdfV/N1/bINUgpA6EnvueboLtADRXxiNhQf2GpLsoHYY
         h3SUMuXalW7m7jrFSjVBdyeFJuCwDMYClRiv5Ae4HxhIahX+qWgQPTirwoSlYxiZCJAa
         +AQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUi2jDXYmWUAVObeAvrN/auMWZfEWN8/K5K9Rjg4MwRtfqnUkxnWxAxp9LM9jf86Pf3U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVB2j1tPqcsPKDaRmZRkFvw+fvnzzUnl6Hp/VbL3WdQ0x3FZf
	SaygDvCY55j6G197oOmcjHskxOhwW8cM/gcepqMMJxS2EReG62JrugJz8yjQaCZknDZRpidpBpv
	Qg/ynSREjBUtjy0fPkQF3+lzzAuvna6m3Hkd/bEm3
X-Gm-Gg: ASbGnctaJPXoeEa9dDPc6oGreZm9zvnERUbmhGJNm0pmInXBYHHnTdeGTPrA5JQOs9U
	p+OQv3bMF9AJC/bW+mOETW3M3YGE2sJ3N9aumUB3V45Eb3fBUJOXp0Q7MLZpz+porRzLOQEE2VV
	eMP5BWK0V1GFpYyhuIj6ajUeKApi3Q3min1zVg5Sg6XBSCQFCqzjhVJyzO497B7K6vbzwLP8yj2
	h9wPap/hisZJ1Z7DvyFneE=
X-Google-Smtp-Source: AGHT+IHLCDngHaqm1d35Zq76dt69sq1Eb8/W3LhpZr4vmuXG3Ed3TJ7vkp6zVFZA5hFCJnDSxn7t311TgnkpSyfh7dk=
X-Received: by 2002:ac8:7c4b:0:b0:4cf:dc5c:8c76 with SMTP id
 d75a77b69052e-4dec6c15531mr2551671cf.11.1758931530143; Fri, 26 Sep 2025
 17:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-18-ca3099d8352c@suse.cz> <aMqfmzwCu1N_L1qp@hyeyoo>
In-Reply-To: <aMqfmzwCu1N_L1qp@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 17:05:19 -0700
X-Gm-Features: AS18NWAQPijqIrQ4xFfoBcVJ2l0qQApTG79Ewx2_B0nlbyTUd16bMIuKaNKF2Mc
Message-ID: <CAJuCfpF52wCCrddQizzsMHF3myuD7JsH6p8DZJgN8J+DGHx2WA@mail.gmail.com>
Subject: Re: [PATCH v8 18/23] maple_tree: Use kfree_rcu in ma_free_rcu
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 4:46=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Wed, Sep 10, 2025 at 10:01:20AM +0200, Vlastimil Babka wrote:
> > From: Pedro Falcato <pfalcato@suse.de>
> >
> > kfree_rcu is an optimized version of call_rcu + kfree. It used to not b=
e
> > possible to call it on non-kmalloc objects, but this restriction was
> > lifted ever since SLOB was dropped from the kernel, and since commit
> > 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_dest=
roy()").
> >
> > Thus, replace call_rcu + mt_free_rcu with kfree_rcu.
> >
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
> Harry / Hyeonggon
