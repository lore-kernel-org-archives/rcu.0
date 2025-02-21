Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED5212D6E;
	Fri, 21 Feb 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156773; cv=none; b=TTbAOh5DkuwiXY0+0qAGE8UfyIJBJFlE4R8sd2RrnA9kFxvksz/4S6ouiuuHsy2yqOa6tn1WBgE80ZOMS0MLZHgkcPkwRR2uMjQtInzeKVeobykamlXtz4jefN5shwpAKltL+rdToxAmBl86x+3BRuM2nPsL6VtRmjAEUnrcZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156773; c=relaxed/simple;
	bh=vO8sI//TeIWtExyYtaD4Exo5QVqQp3kkPzLWvb0G4ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOblzdqg7OoArobBZUKyq8KMEopb1A+RZHaLgi7/V39FeKyKuXuAdPR8y6WatzD1aczpGyz4M4RsfAhqkM0+og2aqt7iIcBxh9j90qMtsrS+JyNfG503AHFXnDcdu+4mv8VMq2hFag6skU/zKDavJd6dsZHC5Xl2UiiVUT5uC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXkipCZ5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXkipCZ5"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb81285d33so462218166b.0;
        Fri, 21 Feb 2025 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740156770; x=1740761570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO8sI//TeIWtExyYtaD4Exo5QVqQp3kkPzLWvb0G4ZQ=;
        b=kXkipCZ5MjxGNsvkeTGIJtPvxGEArCrlFXSM4M3s1UjSc4HgMs09PKmj9dLpKx8MSO
         WUwnVotf4h7P63KZ14hCORpbmezWaevK0UdiCkABjN5BOkxpKpejpd888nVe4nTaE6vd
         SZPEoAiYYThRCv7IdCpSskIGWTaCfG0+Kh4UypDOwzLVB9X+eJ8Br1dbjvV1rQa9gFMq
         qe3RO8QmgzMftz8x/AB9Yw9+iUx30f032EKxsTYMuQBnYfP5SfZ4w4+MGbGli1DH6TzN
         DTpqQ4KMYqpDRg8+4+a5kp9PA762KHy1BJc6/Mh0cS1TOqo7xlv5LbuLSqUIJVYXgtmy
         JpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156770; x=1740761570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO8sI//TeIWtExyYtaD4Exo5QVqQp3kkPzLWvb0G4ZQ=;
        b=mzEeGnWlqIchll3lFAFfpuXzNLLkT3xbg/Lo7x5b9cj+IngHGLCMldCEgdbu6cOM1o
         msillzqyiJEflkZGdjAnImJzuFJ5/rnuEEf9u3eCT+8iTDKBVpb0HsGTdFPKV8G2KuBT
         OmbHVcaflxE2lNF/UZkoXZvCJgaL3K9NzRxjNUVjeEIKS295SpnlBa8m5RlmwlIqzWjv
         jWFx99GdYtYqkEfFzukgvPDyCDZ5e19oE3P+4dPFaI9aS5QFL9A/BBU5OQ90la+ABrX4
         SJ1koIElkjLv4OdKpmPa6ADTcgikkSJqAAk3x83NlnNh/i8gWrxlz2XSuOdr3+2F/xau
         d9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNPe2J2IeUW+ptPVb/jJNFJWQsSEOAKg6uzSxUc5HyU5yTjiafnB4kjdYYd7gka9McgBHSMHsMSuUiSm8=@vger.kernel.org, AJvYcCWoPjGiGtAXbshvn2/DJiukGiK07RjBcY+ggWBzQ+DEWPyPKJdWCfhylucmVGnVacUmB1dv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtt39+YgEtgLcwSwn07GkJ3vDvRzfsz7pEpljcrT8Ek5JF1Ybd
	kUsqaREbHmSpSYNkwvWSxMeE4IKvRQlAvXNPwn6XfJNnG3bF1+wGCkR3Sxs0TrmB9q1Kwzpz7Qu
	Bx5rqwdE2+5F7mEK98c61H+UOEfA=
X-Gm-Gg: ASbGncueqQ93R3kFcgErkJmd78Nivjm58RGoXa9sRS3k/G4+DkHIpbX6KClIK6OhBRx
	GGXblzz/MG4H6378Yv1HU42QzPDgrJi71lFtMqKr34ktXJ2eau8KtFieG5FJP4+OJAK8yZORYyl
	WuitEkmA==
X-Google-Smtp-Source: AGHT+IHpa7dVTFfLnzKGtw2UdVJJ5Ox7pwmBS6uaFDBASq3wQSqM7Dh70sJDq3JmlljMQpfKXkg8quBGs3JbrAY90XA=
X-Received: by 2002:a17:907:944b:b0:abb:c647:a4c1 with SMTP id
 a640c23a62f3a-abc09e37de2mr406314466b.52.1740156770066; Fri, 21 Feb 2025
 08:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp> <CAGudoHGF8ULGPEE5E6ZCTcVnm3qjY0BfT2DmBjKohW_rDK0JSw@mail.gmail.com>
In-Reply-To: <CAGudoHGF8ULGPEE5E6ZCTcVnm3qjY0BfT2DmBjKohW_rDK0JSw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 21 Feb 2025 17:52:38 +0100
X-Gm-Features: AWEUYZldjsBOz6dW6Mngy0JPyOmqYkSKLBXfGnQS2tXN2Unv8ZD0Hi38e_Hg0os
Message-ID: <CAGudoHHeLDgSt2Lt7AO1qpN7uf-SOJ=LP9y+UG4zv0EY8gA2Jw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
To: Keith Busch <kbusch@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>, 
	linux-nvme@lists.infradead.org, leitao@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:51=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Fri, Feb 21, 2025 at 5:30=E2=80=AFPM Keith Busch <kbusch@kernel.org> w=
rote:
> > This patch appears to be triggering a new warning in certain conditions
> > when tearing down an nvme namespace's block device. Stack trace is at
> > the end.
> >
> > The warning indicates that this shouldn't be called from a
> > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> > and tearing down block devices, so this is a memory reclaim use AIUI.
> > I'm a bit confused why we can't tear down a disk from within a memory
> > reclaim workqueue. Is the recommended solution to simply remove the WQ
> > flag when creating the workqueue?
> >
>
> This ends up calling into bioset_exit -> bio_put_slab -> kmem_cache_destr=
oy
>
> Sizes of the bio- slabs are off the beaten path, so it may be they
> make sense to exist.
>
> With the assumption that caches should be there, this can instead
> invoke kmem_cache_destroy from a queue where it is safe to do it. This
> is not supposed to be a frequent operation.

Erm, I mean defer the operation to a queue which can safely do it.

--=20
Mateusz Guzik <mjguzik gmail.com>
