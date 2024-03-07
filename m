Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33775C8B
	for <rcu@vger.kernel.org>; Thu,  7 Mar 2024 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779799; cv=none; b=VoQjaNphUTcLVTrBXiIiXs9I85W7PLf+zhqJrwxRnlvx/afWn1mXSbxDpCUH4uscazOy6w516oy2aKJ9MaUyma0sCQThOCbOTq6uPDIhzl/X9JGR0ZLzO+iorP8hvK8A5d0jBrUTJtuK8aRo4uiKTEW85VZ1VEquqqlLjBTgdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779799; c=relaxed/simple;
	bh=U/g3rd6umFaTxSMQeIcGcHvb8Y5daZVNnDFR/zjl5BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3khYXbaj9SqDy+vPc3xpVsN2UQ3xEjRRmn5lGM59M3qENAudStOC39WUAG21V+y5OgVJsn7lONL7O1nxDu2A2aaku2kLfK+GezFjC2XfU/wxLwWRbCnhaQSXoSUS5MzZAVoSUzmuCfiuswxmVHUMQgrrgoV/Tj+mAIshDFZ03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cPqfQBFi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cPqfQBFi"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512e39226efso457234e87.0
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 18:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709779796; x=1710384596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W0NFNPBAo82DsOxwgtd1xvCB/a8TS3L7jSXLJGBJiaM=;
        b=cPqfQBFizGjfEJeHEaEs0zKs7fXbIQv7UDAirBosrG/vDpvMjkrQkMpzsbT1wrwfb7
         PYYDFszkQPlv/zRjuXSRsYAe4bWAKuTBl03UX7uF3xWguSwZUqXiiyIAKt2LtIYCnbkc
         6bTTWjBH1mLW8gqpI/paz/rp2X2XZA5yBLEBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709779796; x=1710384596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0NFNPBAo82DsOxwgtd1xvCB/a8TS3L7jSXLJGBJiaM=;
        b=Pa8Rk/iamTk7HAJsgmTF+EYtj8jssFDE6molMHF7XRLf50mtB3Vs4FJE8+BEXX6WKq
         qJ9bkvgBGH9hIq835JI6ce6HJ00M4IJMA2/m0Xa4Z9ErNAXrYRTR0ADUnDcghjF/k1Lv
         DfnNJRiGFxxRzxOvqPNsxy7zkmj8qVQuWSJZjUdaEJPPLnk3kJWzr9WInTzJCPYZiMh5
         bMQaIYm1VW5SS0pLUiMeqdEFLPzvNn/3fV8Utjv9Prrt30dFVQPLQR6YfU6y4erZwHFO
         s0GT1MhQ56d9zsqjJIgaqAbQKDW5rXxraHhvgCbsK8pHIOEAEDO7mWVXIbicaTBJuPC1
         jAOA==
X-Forwarded-Encrypted: i=1; AJvYcCWACmJZRRza2CyZSF+t/ygUGscUBKVfWU98RF9feP7BVdomAt1mUAdOmi1imSHhS3UrofqYDhCO6V81RdWRSuEyBV55
X-Gm-Message-State: AOJu0Yw7AJ/RGhLJdO5hWtcV8LnA/5d4p7ITyO7DjAv37N6lJonj2HpT
	OOBYmasXgNti6bmYLRu4pH5aD4EAdZfnjpeUkAXg5CtYhR7VGdENZ6ojDNQF5A9Pk22GImzAmEb
	FNISgjA==
X-Google-Smtp-Source: AGHT+IELKmBiu1KDU+fqfhtzNHWzR5rvaRlLcppAFNarqYvQvlar6rA8LoFbNWroJoyTqQRhiQMzYA==
X-Received: by 2002:ac2:5b44:0:b0:513:3e22:6e01 with SMTP id i4-20020ac25b44000000b005133e226e01mr455286lfp.16.1709779795791;
        Wed, 06 Mar 2024 18:49:55 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v11-20020ac2558b000000b0051325492ea3sm2848984lfg.203.2024.03.06.18.49.54
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 18:49:54 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so454178e87.3
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 18:49:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/tc0DPlknsPRLF/K+aP1vdQCyy+9+dF08If5XkJRT99LgopNTXuo6T4FjavJQ+cStfg/zJAqGXoh9K87HyGKiDm8g
X-Received: by 2002:a05:6512:510:b0:513:3b64:978b with SMTP id
 o16-20020a056512051000b005133b64978bmr456376lfb.23.1709779794360; Wed, 06 Mar
 2024 18:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop> <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
In-Reply-To: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 18:49:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com>
Message-ID: <CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 18:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I dunno.

Oh, and just looking at that patch, I still think the code is confused.

On the reading side, we have:

    pipe_count = smp_load_acquire(&p->rtort_pipe_count);
    if (pipe_count > RCU_TORTURE_PIPE_LEN) {
        /* Should not happen, but... */

where that comment clearly says that the pipe_count we read (whether
with READ_ONCE() or with my smp_load_acquire() suggestion) should
never be larger than RCU_TORTURE_PIPE_LEN.

But the writing side very clearly did:

    i = rp->rtort_pipe_count;
    if (i > RCU_TORTURE_PIPE_LEN)
        i = RCU_TORTURE_PIPE_LEN;
    ...
    smp_store_release(&rp->rtort_pipe_count, ++i);

(again, syntactically it could have been "i + 1" instead of my "++i" -
same value), so clearly the writing side *can* write a value that is >
RCU_TORTURE_PIPE_LEN.

So while the whole READ/WRITE_ONCE vs smp_load_acquire/store_release
is one thing that might be worth looking at, I think there are other
very confusing aspects here.

           Linus
