Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A721CC66;
	Wed, 26 Feb 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590125; cv=none; b=Pnq4kQQTlhhsLf5sUgI1d6GHPUnPuGicF0/CQqDrs5BUqFYqt0K3Ol5dnV8qicH+V33e3Z9jKWz6af/IfCEJTl9fGMpmaGPHrpzWfVbW6xvp0L4jghniWIbcrnGNlDe/RXCl9PCR50Lj9nQ5Mr+mSZI6JlTik1h5Q+IZCmHwUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590125; c=relaxed/simple;
	bh=1RAn5bNL4+9EQuzXgKRCtT0XlmNtPhYC/UhyweTJTjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Twtgnkmm6P1kbuf8uwPkiNGZCc663yc6w1pUA9CLUq94sE/lMrZHVUhtq5X/myIUInBUWgehjEo/blrGU+uxfzc6rGYhshTQE021T9+6QnlL2/m4ypoHH0iyL4LnocdfQ+JEhpqbmVO9e3EdkLwzkuFItg42WMw1rvgr6ahEtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m03dvTPu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m03dvTPu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so1216235e9.0;
        Wed, 26 Feb 2025 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740590122; x=1741194922; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RAn5bNL4+9EQuzXgKRCtT0XlmNtPhYC/UhyweTJTjM=;
        b=m03dvTPuK9egrBhq5qoEaAOzQlU8Jfg9Pc7X1WhNt8Tg6hK3PjDT0Vq/JALq43EuER
         po+nn8cafGyVtjtbQcuPiUkmfQjzvMyIWWQMfbeouO/SzUUZQnliIyMhGORIEUIx+n2T
         BCD4rPHVFDXGJqtt6ssZwLWod/Jw/BDnTv84gusF9yFCH/LedmngqGiIj4CpnC9N/sIx
         5z9h9PDGvJ8GT9GzLXByzFKuPYeognasbDlmX69/i7x0nepfSNB2RYUNSXFc9THr7lAC
         faBjnquazNSIRFzCNv685jvjWEV3kwhRwH6BRAen+Iz3MuoCWzQb7XSCRXb96r/BWq8S
         ZC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740590122; x=1741194922;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RAn5bNL4+9EQuzXgKRCtT0XlmNtPhYC/UhyweTJTjM=;
        b=j94+iDICD7AdrVe6ghqkFLxf614EQ85q7VhkVpz7U28L7fRU+V2C9qZV+YSACW4aCz
         riSmSkI6NSG0D+kjJjLfZ8oiE9Fu4YWqM7uaSfd7MwgRZpW+CI/Pslx2Sasqjsxoqb7f
         EnpqWSLNiNCuCyQU0MlKtQYgb0KskAjAhwyrDOhNB/wAr5yD0wTQfJALudJbQt6W4LJo
         O753FsF9APMSJ0i0DULzyTg5YNrNcR6O52+x9E8KWUd936uJTV5AxcemRmfML0NONik/
         ZmoJ/xWn/0iQIVDHf+JLfQAiL6RtAzParErLu8zN28JdBsZ+oPFN64oW/QDZc5zl9euj
         jhWg==
X-Forwarded-Encrypted: i=1; AJvYcCWnmRsXqGB/IQIfqr2/dWk4Z5KEjQGPSc9D3Gtqb31o5ONtcx/GkL6AyWKLR5DpyjgVgVh5@vger.kernel.org, AJvYcCXxquVtJKKuyRAvEOi0Fo7oRHaouCa7kq9Gj6lf4b0GAoghIvBeG+mkxEWeuBTfAQ+nyCFl8RnV86vnO8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKe+BJzpfYqq1aiy2I9GZhVxQCDJQzqFuLkPSx3rLZA2QZvNAU
	erwW5b3aGtKsvmnxRrSysFWDugdQ5bo6A/ZH6AIqQgMnuHV7KF9p6K9or4NooSLExEQ3AbsH8QN
	hVfWKNMVLnyQ1keyWjhVAY0aPZ58=
X-Gm-Gg: ASbGncvqkEL/4HRMOMXVYvyeCWveeDIYh3rhVlzXNt7U8zYA66AnlXilQXwjDl83ozX
	OEmb1EhSZdZefD1pKvyI+w72ChcbjjqHaQFB5hDpwnemgOVgjWTQ31exGg8K4f8X+BHtm1XNmp8
	3MFAUeN3pWxkb1qAoBcT5iBps=
X-Google-Smtp-Source: AGHT+IEtBMoCTUav6TSmsKLpwW3a3MxoLkSWBfm5obvrcgUQcp2uu4q4pzqh/afdF4jNJX3Uzx31+bQWBYx2Js2h/d4=
X-Received: by 2002:a05:6000:dcf:b0:38d:c44a:a64b with SMTP id
 ffacd0b85a97d-390cc63c045mr7606159f8f.48.1740590121799; Wed, 26 Feb 2025
 09:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz> <20250226170053.lxpreaegz5tysef7@offworld>
In-Reply-To: <20250226170053.lxpreaegz5tysef7@offworld>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 09:15:10 -0800
X-Gm-Features: AQ5f1Jp-y9BTFtvA4Pj5PaiujmHZngx-Du8gcaN_n9QesEj3-kDANfPP_INIgoo
Message-ID: <CAADnVQLAfZBvSyqE=2sbdH-kuNhvAJM+R_qMzfgPv=MDF+=VQA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/10] locking/local_lock: Introduce localtry_lock_t
To: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:01=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Fri, 14 Feb 2025, Vlastimil Babka wrote:
>
> >From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> >In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
> >critical section, but it doesn't prevent NMI, so the fully reentrant
> >code cannot use local_lock_irqsave() for exclusive access.
> >
> >Introduce localtry_lock_t and localtry_lock_irqsave() that
> >disables interrupts and sets acquired=3D1, so localtry_lock_irqsave()
> >from NMI attempting to acquire the same lock will return false.
> >
> >In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> >Map localtry_lock_irqsave() to preemptible spin_trylock().
> >When in hard IRQ or NMI return false right away, since
> >spin_trylock() is not safe due to PI issues.
> >
> >Note there is no need to use local_inc for acquired variable,
> >since it's a percpu variable with strict nesting scopes.
> >
>
> LGTM.
>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>

Thanks for the review.
Do you mind if I apply your ack to the latest version of this patch?
https://lore.kernel.org/bpf/20250222024427.30294-2-alexei.starovoitov@gmail=
.com/
