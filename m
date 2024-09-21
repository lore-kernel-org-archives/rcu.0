Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDBF13DB88;
	Sat, 21 Sep 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952857; cv=none; b=VfXWXOqltYuUrj15ehp58yanH023fRX+1cuPsnRehcHOwEk3L3KheTMOGX5dmSDBjKf3zybR8xw3YIMzr59oHYoThRz7EZ4jtv/rlzSo8wAgTMsJnxVPDHcDg92SnvHu0IIvodmGvxaT3IXElNJxMDjHCc0Fxg0PZW/OpFmjkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952857; c=relaxed/simple;
	bh=lXi96evv14+QCYlApm0+UJoBiXFJ8NjukYfGt9BkWKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rxqcurucy3BlrussftHdqeikOLG+JmK0kmus64i+nZrMQD0MQVDiS0wE4duh08VRcAui1pf8gD0jhga2lfx1TM5xrjepBoHMsfugsa0VLyF/rACDHr7Rv4ybcfLUpNp4pHkyOQVu5LDx87qBVlOhlFuvzG4nzbw0BPsCd4gJ6vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHle8M0Q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHle8M0Q"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2570622a12.2;
        Sat, 21 Sep 2024 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726952855; x=1727557655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hp63dP1vIuDmvqlV49DXovWDm3PAu6Ul2JWTXyenPI4=;
        b=PHle8M0Q7B83NqfJUmQdaUlnaVTyoS1Ou5R59fEgwkTmTf83RN7vL51aXn2lk6kzNz
         /Tq9lN9Ffxh7KYnvpcbGT+DiTlale7tKB/ei96pnSsYFjEbPl0IHZxHvgZr1444yEmFN
         z6azZMPCmxwm/8qMlO6ht2VgVAyCOQxNbKG+fBiIaRQNQVDikhINXQ5hCcNogbE1k9i5
         LP56vUMedgaSEhij6f6TExOHoZ9dIC8aqrcpmviZOMgkbLAj4v7t5WCPP/IllgJYhjzW
         PScE5zz4rCWSymiIeOcXMcwqrE4ENpldPFNQJNiJ2M4RRC3BULDlDOSLUQj8X9K+LPa9
         ZSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952855; x=1727557655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hp63dP1vIuDmvqlV49DXovWDm3PAu6Ul2JWTXyenPI4=;
        b=vIpeZRGBqnrVAwIJM7C6BDwDoqKMCBbKxYiMMi30DAJDqPkJwwH/U6kzW1QEcDgnvH
         raQRLv3McMVcACuMhPKdM/JicGFRZXG/GFZkmd8w7mLjeO44hhi121ON9Zf4advTLAc1
         BWLDloBykdt2n5nzuHPU/U4LTqzfeTJeg7G5UNucUMJ3mjywNqksbAtgxLWdE4uwRM8z
         sqMqz6LAHaUX9uNs4UiW+U7EVfQS68OEHI0hinD1uc6QnazjfqdovpCcc49RZoc0JACh
         tkrDCkIOTxzKG454DgfsZMcVIMafPNLmLQuxrNviQvVzIN+ARiHiAcytifxb15Waa0Oj
         U0ng==
X-Forwarded-Encrypted: i=1; AJvYcCVzkGqoztyeIHZV1iSd8hqcp8aM9unbJSkdPbJeEwK5PH3QHlgEhsWj3hi+C1rqOgx/KiNzYNrp5E9Ph4s=@vger.kernel.org, AJvYcCWFzPDqjSADhUxHRlESCL4UHoz4vk7TNlbRH6JpGDDAEfPeRyhH16zxQ5FQcGLstW4UiPlB@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfRqHXrffu1JGG4LVTDHsOIu/2evG6Jn+8pAFSnr6a7cggPkt
	EIiTt5ydGimonQejo6uHWcKIJLIM0SGrH+DjD4dSuSHL1Ry5J0O2xYgLrO0+1D/4/9Yl0NIr09m
	ZYQFarvB01VESL7X+PWDlQK1d5343om4Dy11D+/NK
X-Google-Smtp-Source: AGHT+IFPDomxth+vXXT4e8DSQaPpBIrEW3tjeUXSZGZ0lRBYZWDifbwG+csE5HvRoTEna3+xfdCTpG/AjzzHz8zXHdw=
X-Received: by 2002:a17:90b:a4a:b0:2d2:453:12cb with SMTP id
 98e67ed59e1d1-2dd80c02ad9mr10560062a91.2.1726952855430; Sat, 21 Sep 2024
 14:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Sun, 22 Sep 2024 05:07:23 +0800
Message-ID: <CAJhGHyBOwwBhCW96MyFGPVWed2ko37mLeHzta2BzL6T-TzUnmg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, 
	John Stultz <jstultz@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> +/*
> + * hpref_hp_get: Obtain a reference to a stable object, protected either
> + *               by hazard pointer (fast-path) or using reference
> + *               counter as fall-back.
> + */
> +static inline
> +bool hpref_hp_get(struct hpref_node **node_p, struct hpref_ctx *ctx)
> +{
> +       int cpu = rseq_current_cpu_raw();
> +       struct hpref_percpu_slots *cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
> +       struct hpref_slot *slot = &cpu_slots->slots[cpu_slots->current_slot];
> +       bool use_refcount = false;
> +       struct hpref_node *node, *node2;
> +       unsigned int next_slot;
> +
> +retry:
> +       node = uatomic_load(node_p, CMM_RELAXED);
> +       if (!node)
> +               return false;
> +       /* Use rseq to try setting current slot hp. Store B. */
> +       if (rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
> +                               (intptr_t *) &slot->node, (intptr_t) NULL,
> +                               (intptr_t) node, cpu)) {
> +               slot = &cpu_slots->slots[HPREF_EMERGENCY_SLOT];

Can @cpu be possibly changed? if it can, it seems @cpu and @cpu_slots
should be updated first.

> +               use_refcount = true;
> +               /*
> +                * This may busy-wait for another reader using the
> +                * emergency slot to transition to refcount.
> +                */
> +               caa_cpu_relax();
> +               goto retry;
> +       }
