Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A1139CF2
	for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643205; cv=none; b=lkWqXoUYiDncAxKJx8G75uZztehu9YeEHyrYoVtqNnil2HBXQWLm5+LyZZFsVVudev0Gve5qx6NdykXEbwUdDe1uvH1s6K8m2va3ODUZ62LGkdc3XxC+e94veRo63aw0ucjA7hlwnYgk/lT4wwYFalH3utT7dH6iPujTPdy98uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643205; c=relaxed/simple;
	bh=SUCLPRdiDfQEebQzofMtI7RfAk0joQ7oLPvKtvGVbpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSEa1eTflC60cIt6G3i7+1U3ah7S1b5MXrZ4GOB+q69+CNo1eOgDJFUPdGDzbEbaHwT4ANAkzacZrKfvuiKbHF0LidlYI+UYDiX4l07lJDTEvbDcWOabb7XeI4aWO7+vPJjum7Em9z18+uYF93LbOHy2lryoe9FWGvWxr3T++2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JoZJqCRG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JoZJqCRG"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so6353510e87.2
        for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726643202; x=1727248002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VL5JF+54OUBRwP0OaibNmFvncta2Ria7W8uRTQUIHio=;
        b=JoZJqCRGLMzlsL/8gy4OEKw7c7DgOigERYrMOePGffgOKRHCrQa1puJSEWZbLGlAjA
         D59tSAHwMkNjiTtnSeHAMENnssYJqEJDO4BsHX6edgsq0S+OOEc5yWMtpaaxc8EIGF8+
         pbEIec3lJos7NnJl5loLYQD1vcu7S6atTEndM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726643202; x=1727248002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VL5JF+54OUBRwP0OaibNmFvncta2Ria7W8uRTQUIHio=;
        b=nGi/1HsOqmHjLrbRogYc9ry60Am10mqo3dx5cL97fyEYGszBg8vqFkV1ekRCYS2BuN
         qGjPF3ng0+F6EDvHKlqUvwgmJqFJRot0GNVXbzmvqN1t1aoolVP7/2xuRa53hy2HhGBv
         jARhQa2BgAJdm6lsOPlHFJq/jIGsdMwXnzWw6nhMR3OcV4PmXiLUWN5aWtBzOCKpPt9Y
         zORvVe25DJlPmCZtUF1XsfEDRZk45ov6KH4S0tnnIAIjOxT8xkVI7QMpnnqMc6GiLGCN
         OJZYnaMZvty+4bNhpvUHI80RyzZAjlqd2e09jlXvqTPvb5HJSmTL5QlNuvehE7E+vLoT
         u/bA==
X-Forwarded-Encrypted: i=1; AJvYcCWqTY/l3KYmBEn/HD1hDjcfICO2QIoGvolVcj+JB2l1AL4MtZNzWmpHl8YsZ4lNM/o7Tic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn43towewGW0Wmx0kpjjUWsG450nSIEPkal8lgXg/ZtzIHQwqQ
	yyCzeIMWOHMXcTGaw/qvAGCzvpwAYnuIhpi3EgnA/tIP+gnARkuZzHK9e2zmaEcIN8nJZDZjTwX
	u5u60LA==
X-Google-Smtp-Source: AGHT+IGOYzLxvgH+pzbkv25Gsx/WhbSiRVfBDYzFlCxqiv4e3aPtpI8kkZtY2VJTNfHKGljK0rDPUg==
X-Received: by 2002:a05:6512:4017:b0:52e:7ef1:7c6e with SMTP id 2adb3069b0e04-53678ff2e7fmr12498791e87.51.1726643201441;
        Wed, 18 Sep 2024 00:06:41 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870966c9sm1434920e87.149.2024.09.18.00.06.40
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 00:06:40 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53653682246so7622653e87.1
        for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 00:06:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgO3bia8xxpk3zNrO5/eCaet4gKvYPr+CiMq+87uqQOOiuSulLKvyF5TiatyqDVk66MuA=@vger.kernel.org
X-Received: by 2002:a05:6512:2208:b0:535:6986:9810 with SMTP id
 2adb3069b0e04-53678feb164mr12882725e87.38.1726643199826; Wed, 18 Sep 2024
 00:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
In-Reply-To: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 09:06:23 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
Message-ID: <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.11
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Christian Brauner <brauner@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 11:45, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> There's a small conflict with the rcu tree:
> https://lore.kernel.org/lkml/20240812124748.3725011b@canb.auug.org.au/

Hmm. The conflict resolution is trivial, but the code itself looks buggy.

Look here, commit 2b55d6a42d14 ("rcu/kvfree: Add kvfree_rcu_barrier()
API") makes kvfree_rcu_queue_batch() do this:

        bool queued = false;
        ...
        for (i = 0; i < KFREE_N_BATCHES; i++) {
                ...
                        queued = queue_rcu_work(system_wq, &krwp->rcu_work);
        ...
        return queued;

and note how that return value is completely nonsensical. It doesn't
imply anything got queued. It's returning whether the *last* call to
queue_rcu_work() resulted in queued work.

There is no way the return value is meaningful that I can see, and
honestly, that means that the code in kvfree_rcu_barrier() looks
actively buggy, and at worst might be an endless loop

Now, maybe there's some reason why the code works fine, but it looks
really really wrong. Please fix.

The fix might be either a big comment about why it's ok, or making the
"queued" assignment be a '|=' instead, or perhaps breaking out of the
loop on the first successful queueing, or whatever.

But not this "randomly return _one_ value of many of the queuing success".

I've merged this, but I expect this to be fixed.

                  Linus
