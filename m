Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F291F5848;
	Tue, 18 Feb 2025 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904082; cv=none; b=koubVJpjvjB0hNUT7pbrMAS6iOjTxa1oQQNGSILOv9/LRfVBnBY1DkYShmJ9vqcRbhYHvdFi+Iip/nh7wV982whzGrS6yKnSBP25/lGDfEsO250iIAMZPUM/ORddzzqYqpkF6dUQgJPpjNJrVePXdzwqYbxTUyMqWnJTrt/2Ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904082; c=relaxed/simple;
	bh=064kNw/EgN0UHYWByMwYl66J+KJpEyOx8IH/nhyVgZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7bIuVDkiYz6+crmZdv6MUn4p236URb257LnyjqYK5QqqZeEFIsjMc0ytqNp9AvKLEQ5sBeJqG/ABp+Q7aJDhtBK8XmSRLG7BjhTncKcjqzRoCcMYs2iY+K9NBJ4HFX8vyh4/NTOmhsV7mGdY10o6soXtxQYIuu4PBgVGmyXydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAK2nriu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAK2nriu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so3230730f8f.1;
        Tue, 18 Feb 2025 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739904079; x=1740508879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=064kNw/EgN0UHYWByMwYl66J+KJpEyOx8IH/nhyVgZ4=;
        b=NAK2nriu75OA7y6JkgfVba13muttU0EMJ7Vi0Ud35Rfra8jc3lktv4rn28JM0LC74I
         XP5sIcwL8NIumi5T5nCIn1bXMPge+5yiyygC16CalyEVG8kwW3qtvW2Gw/uNA0DvgvFy
         eLbwEpCSG+9lGKybSLP1KoTi4JdNy5f7kvybZnYMZulB63Mot7EX1uzNbCWx2F7532zr
         TF49XAAnGeTup3RpTnPsBsuYkpjwBegm44v7EkCR7a02E+KYTBOlBBYj7pv0Dlm8nRp8
         V8ScHlscGiQHmrHPiZsGpeUrooee0m9ZLuXI660SB3FSzllz/NF2GrixMrGu1xRHlgUa
         OpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739904079; x=1740508879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=064kNw/EgN0UHYWByMwYl66J+KJpEyOx8IH/nhyVgZ4=;
        b=BaEe6T7TTPy33vEnAgj5V52Bu4sdLiUsPpakGQvBznjXA3sjCT8yrcSfSLMh/YYp87
         J8+YU+//5sOgNgUmOQEsDLlxf/mLeehtn6rWidCLZ0Cvnc9cBw3c8LDJ64WVhxAtqLjU
         uUSS2yZAHpPi/5uRr7PRKrt95qh9nOAq18xYa6k7leJj1OSqq52UzdyB1KXFtlGqbJD8
         ULqau0OBzzb9TV+HLKn+KPrSStQk+7SK9XjwWNuWdhioZFGAvhyDO0b0bjiuV0NhtCyk
         0o1H9Bzv+/f24wunVrCY+EWQcNB4xeThxwSkC7LxcDn0e/AdkWIPXsVvMpguO2eyHJfJ
         l2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqijPNfTp+PKvtqwXD/8SUAzy2PV2P7DGu0RshxGUpyfAHsVQTMkkQgB4o9kpESjsuplscnYqymNnyJI=@vger.kernel.org, AJvYcCXNjIFlopaj7p5tSIOYH/AmguBgzu4Fxkp3JgQExe3kt7ElQeNBSkzZq+cfcOgHrJUNUf3L@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVHBf5OwlVedBnM3YUVw+zD54X/DHHgSh00+0CXW/dxPKdN5u
	S7pV7qyU4ZjTEWX4HYwpp7+RvQGnYKHc1zyWIXLFL+SABs1QltjuOpbJ2bEJ0R8dUzjv8diQLQO
	b4DQOscSCzsgvaXnyLtijSGw5xXA=
X-Gm-Gg: ASbGncv17py59sufgBXC3He68o1+Nr3LN35b4bJabykbGY4gi1/u/H/jOBwHDJKhDI5
	i0Ij5UUAeghgbksTrS7rUhh4G1BLKJ9GP/p6imm/3J3di57x4iVeKwYH/z28f9SVqM5XE9iqGZ2
	NmHIkqjLj3GEN3
X-Google-Smtp-Source: AGHT+IHhkiMm6MGXT17M9xfM7NM8mSv/O9ojIthPD9COWHkCQBAc+IHDA5g5Sf9lOqEzMmvYuHcqhE3bUTjjvjqFZhY=
X-Received: by 2002:a5d:6c63:0:b0:38f:4b2c:2475 with SMTP id
 ffacd0b85a97d-38f4b2c255amr6762956f8f.20.1739904079217; Tue, 18 Feb 2025
 10:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz> <20250217141956._01BcsrG@linutronix.de>
 <bbb29d35-0a7b-4b19-b0c4-5b2e899b7b5e@suse.cz>
In-Reply-To: <bbb29d35-0a7b-4b19-b0c4-5b2e899b7b5e@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Feb 2025 10:41:08 -0800
X-Gm-Features: AWEUYZkw7pLuqM8rpwQ14Nm2IrYgdo2AXxznTsMF9KECxxoRCxM2XTApIligPx4
Message-ID: <CAADnVQL_3dayDBboTkUs6g4PmEOpFhufx736eaBqoqjZcnUwiQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/10] locking/local_lock: Introduce localtry_lock_t
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/17/25 15:19, Sebastian Andrzej Siewior wrote:
> > On 2025-02-14 17:27:39 [+0100], Vlastimil Babka wrote:
> >> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >>
> >> In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
> >> critical section, but it doesn't prevent NMI, so the fully reentrant
> >> code cannot use local_lock_irqsave() for exclusive access.
> >>
> >> Introduce localtry_lock_t and localtry_lock_irqsave() that
> >> disables interrupts and sets acquired=3D1, so localtry_lock_irqsave()
> >> from NMI attempting to acquire the same lock will return false.
> >>
> >> In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> >> Map localtry_lock_irqsave() to preemptible spin_trylock().
> >> When in hard IRQ or NMI return false right away, since
> >> spin_trylock() is not safe due to PI issues.
> >
> > spin_trylock() is not safe due to explicit locking in the underneath
> > rt_spin_trylock() implementation. Removing this explicit locking and
> > attempting only "trylock" is undesired due to PI implications.

Makes sense.

> Just to be sure, you're suggesting how to reword that sentence in the
> changelog to make it more precise right?
> Alexei will you incorporate that in your version?

Sure. Let's squash patches 3 and 4 and add above
commit log clarification.
Whoever respins first can do it.
