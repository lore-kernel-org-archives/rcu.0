Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208B32B131
	for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789794964; cv=pass; b=CDfBT4FTgy5rbJ2xRN1ZvjQVWCagF8YYnZWHX0nVi687v/an7SU7o0RkAXbp5RACWBf2kIFKkNMEwBw3Ut2xJLBtiwg/sdq+VKcg6cim+Ky9ukP8tyjih9qtSHG3XHLzjDLGdJRMQD3s+lzZlRJKrYVIR9SENyfgPrX65tK/FWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789794964; c=relaxed/simple;
	bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivVnHTEjnTFZL1ZIE79yvKzWdXcL8Rl1iv3t1967i28ehsOCujGmqTGS6OB93BNxdtW3KK5ybdIIlH4Xk+UxxCMkp6En/HABZQVYB4p02BoS1lqZVSvLjZAcBE+iPQMLzKeFT1pSm4ZHKY50ISR2+uH3oAc4dD29/L/7I18rb/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZlnxRLY; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZlnxRLY"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a8568e9so1223091b3a.3
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 22:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789794962; cv=none;
        d=google.com; s=arc-20260327;
        b=p6sVu+kcMMjmPJN6Ir91bXX+NnZfh1SEi08zLGf/eMiVztuGg/sJxxTTwFoqqwkchg
         ln3WB61wYXdJ6FGbU9uEkz+eACRoWOGkFA2/nlD+MWsDn6SsxslXTEiJz0ZEwUaNieM+
         X7NkFZiGdeJXUUb84xEvaLKs+MECEriepUMVyCbKVEyrgJw+mgaL/PHZUs1LRKGlCpmK
         X58WF1f2fblqBaFkGzfZ+TEeuQLlD2hbEJh/UFMx0puPbk9R2LTHSIblsLlEM2ReuBby
         RedHooMLnyYlCnKLUYXPoI7lmVdZb1RpxoF1n+5XALepab31d+M5LCmqifM4sedinT+S
         j7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
        fh=uQSkorEgcxxwCapYVZ0wYFt+90JaLqA34ZVINQzVU00=;
        b=a+F0xZneo8LUNFE++NlMXWJzUhe2aKgq6k6idfr0uclo3m+4+CxNf0MmO+8Xadob+A
         TgfO9RF/PUClU6weppDWWFXgOYYWktDe0K0W40sJMWIvSde9YWtwOghhj69xP1u6ZA/n
         zptUZj4FK1TnDlJn9uiXPuahllMclo+tq5kAFiKgz95A6cyOeUQq9FwcQ+Qs2PhaKHFT
         cc4+wFOrRyWEzUa9OzQ3hOqVDuBdq7Am3C8Xo0Bew3m8bMuVWsNgNoyZNsjjRj5fQVnH
         b1oA5nY5+acmdBMFNjO+f88B+UK9ASYJZMRIOJrG4CPRhRiTY61f+JwcVE9Q4F7A5fmI
         cLTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789794962; x=1790399762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
        b=hZlnxRLYYuhq6rOtbSY14BCpjRI0nniuC8wpAjxDkUfGQnbn/JacPgH0b/eS657MmA
         rxJGQbcOrGEZeUHGa4wvg9vvePe4KLbscy2nA0xbIYWB6xMpBGS7btTwOj+qC7UisC3K
         yUqkSs6aGw4M0wABWvAG+1WSSgPnwW6eObsbi9Bzd0idLIIDA0agDvJ3K3WMQMOAXzRd
         1gT/blG97Dze/aLGxocV6IXLAaumyjmDORSrCtDKz9DTzYhWj/W+MAO9C24qHhU2y/m4
         ZpKniXKOeJgOgcc1NOAz5EBtCNBxBQWAU94mQ3mvKafMItGrvErJaJdoN3bT1dHdv8Qn
         H6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789794962; x=1790399762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
        b=LTq1IgX+/rcT3YFAQAqK0rTWV/8lUNLDCWqcahNfFRT+Uoa7dBhspyoqfagHWQ6JLK
         9DHEy4jcH8J1hwy+ST/syRpjkNbnr05gKOJLQjoy8Ysglu1iVJIWS7H4fu2+xId31JSo
         5KNZw+i/6vKO+cAFyfNrLrIwlI5iz3Xe71d5BsZMzOk4Bq89tgc68BUQ17gQwgyq5iUm
         fTzvYJLmycr4EacNFUiw1WMQt8RdaCQr1yl006FMeqsWhVsyNdh2XQ0yGnosZ7T321jT
         FB3Q/BFslfnqUg4ZJIvSvg6Wuyi1RC85fRgUGrZfuC3EmXUMjb7fnZQiuqApegJHEnz1
         liIg==
X-Forwarded-Encrypted: i=1; AKwUvBydE8jI1smyHrx21w5gIf5bGzXt8+8l2VZXcCQ1ufuJ9QifIC9+t/HiP8JLeUS4c78YO5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++l2uuTmzZjxl93VFwE6MeO2T6JSTG16CTNyzZAVwFmtJH/1dVSJ
	/8NPuj2uWZ+h+EdjIh9MHLvHcqVGWeSrUvkv+R/Tiwb1YkGdNQGz4V/Y3D1TY9kOJCZFdfVr1F4
	IUJeNbhbr/KFq8jKizIgIVnJ1u+FN9KQ=
X-Gm-Gg: AYBFou1eFCz2iWkYlPG3PoigbyLiV3+uZG0Aeet4QWPFKdfZ7Dt/dAsnOkJXWVBQvV5
	ljC2hKNEh2T3UxMjZaTj1qZcLx9u4P2k6jCvh6VXN+vLDsUXgOKOy08CXzpXklCDW8cKs/RCrYr
	c+ecz0A6BDk5bl7k4bVe30Z9f4Px6vHVmJaHgXVvcadgNqkqQFDgK29FqXypiJuORJby63ec/jX
	8omlJlmXm7r9z/0J/tsYJtNHo4imWLT2U/uxzgKa/83vzcBUAXo1UxaldXuGESWqDdz+efHV3jq
	dHY9EPxv20PDpEC/coMcKV3S30lNXqCXdomCtldYTwx7jMmc1ucd9UWIiC3xbCy9pnnMKUVn9A6
	7drMcTcryMoW/8yJirP3/4xGjQ+6UA2bv77Gd8C9Ka/7CFMCJefmBHSRkKbDtPbsP/ZXd/qjPTg
	==
X-Received: by 2002:a05:6a20:d703:b0:3dd:a196:9079 with SMTP id
 adf61e73a8af0-3dda196a86dmr2664642637.67.1789794962226; Fri, 18 Sep 2026
 22:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-1-puranjay@kernel.org> <20260915154248.3612028-2-puranjay@kernel.org>
 <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com> <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>
 <ede9d515-a103-461e-8244-656af641c6c9@paulmck-laptop>
In-Reply-To: <ede9d515-a103-461e-8244-656af641c6c9@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 18 Sep 2026 22:15:50 -0700
X-Gm-Features: AcwNN1XLF5-45PxpYWROshnd_TTN-hd81UJzSUteWcNqwlQM50o1v9bv2Lrt7Do
Message-ID: <CAADnVQ+bmTPScUBfOtD8Sj9H8KjAqU2-XocFsP3G2qgNA7q_Pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:03=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> > >
> > > I tried to fully embed structure back when implementing bpf_task_work=
,
> > > Alexei rejected that approach, because some of the structures (irq_wo=
rk) I used
> > > are not in our control and might change. I think this applies here: `=
struct rcu_head rcu`.
> > >
> > > Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uN=
GZ3OBQh4V5Zt=3DWnQ@mail.gmail.com/
> >
> > I agree with your analysis. Although struct rcu_head is unlikely to
> > change but still, I will change this to a heap allocated version where
> > we only keep a pointer and not the structure inline.
>
> You can always use a union, as is done elsewhere in some cases.
>
> That would preserve independence from the rcu_head definition, while
> avoiding the need for memory allocation.

In most of the cases kernel internal data structures shouldn't dictate the =
size
of uapi struct, but in this case
struct bpf_rcu_head {
 __u64 __opaque[8];
} __attribute__((aligned(8)));
is the right trade off.
I cannot imagine how rcu_head would grow from here.
Two pointers is what it needs and it will stay this way tomorrow and
years from now.
The rcu logic needs a pointer to callback and ctx. So two pointers.
Let's not introduce memory allocation for highly improbable rcu_head change=
s.
