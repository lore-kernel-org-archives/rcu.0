Received: from mail-pj2-f31.google.com (mail-pj2-f31.google.com [74.125.227.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93E378D8B
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102161; cv=none; b=XlU3l2zElYsxbnsXkIOem36p19dhyu+76TZxF5ZMnqbNzrdTTumWUyw/zbxpnkEN2tORddp4O3zEZoV5+IFxobDPvhvYxzMixkljW5As/ytWxV0i9hLDmeRIZMGr2inF3IKCHyDxwxZgS72+9lEsIoSR0KJoRDmhekxAOmct7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102161; c=relaxed/simple;
	bh=FiXQQMnSThXNo69Khk8wztrgg1MwX3yS9NudTb5lLzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c+pZoqsxvdIROcqUgVvgYdJoHhbWO7zlNsQeptwdeHibgccBdN4cNfGaVSPcmQ6OpsfPLQUVESEsYMXAtwS6A3uWNhPlCVRuM+Y+WyvIbfT2WvuEectrSELFY+ll1jwIaoenziNdlEUW/7uOEr8eu3KXLWvXHN77kDYYRCXqj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdga4HmU; arc=none smtp.client-ip=74.125.227.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdga4HmU"
Received: by mail-pj2-f31.google.com with SMTP id d9443c01a7336-2dd53691be5so1030545ad.1
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102158; x=1790706958; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fv1Vy7Ad4KYNfz8s9Yj2zAWmlMEYHenEzx9mXO0mK3w=;
        b=Qdga4HmUhNHZUgFQ2vXg3po8MYe4b4qJdWSpOHTxSDfTWMUygebO4lq9MZZOPmdkT7
         VO8Gi3PPMcuYlne1lR5FIJAMGpurHmCd22HviRrtc41Glf/UX2bQRlOJuDBd8qgg6nqq
         r1ffPiW4HV/t2ZBx8OcO3qRTrmBJeCL8FptBULlUjarXINk4CGJGdnrgt/g75m6oqbkl
         GjOnPTAmEHGCRyCxkE0nM3Rtabehq3tkWychOaB4bCstreFTyiqZtL85W2IAvRp63jtJ
         HnWkKy+z8R3+DV84QkA2LfEkEb6Zzo3Wg3rqcRpeF0jggDyPhbfxV1wMlaya6AkMgJM/
         K8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102158; x=1790706958;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fv1Vy7Ad4KYNfz8s9Yj2zAWmlMEYHenEzx9mXO0mK3w=;
        b=QYuPey3Laq7D5TlDGsD9goVuX6csLjN5UT7rlPH4pE1T59bA4fXdEFFFKtpi/J4sdy
         dkRyaWhiFT/QNIpVlh1gpZy/mDucud/Ir+zCI/dq97xFszgv5Xyyugj4oiYfCETWBcBj
         xaqMspdRoHViosuiuZKXH0Ifzcq6LQqVfd/2anyR86BmEMCFGxZE60pbxoWQNzs2Uy8d
         2ufFcMvrFLG78e/k4iM/nuMbQ3i05JaK0Vm4qqdFsMJI4MMYUyPEffXWlflOd3a/3D0t
         izx49LU3tEZj+OxpOE7UlmEp60KEBpsen0rqU+1vywHsymXEbQ4++2Hu7keAnfCqcRkX
         M/rg==
X-Forwarded-Encrypted: i=1; AKwUvBwsxJZOvOKXm/xnKU4i2ExrIdoOmeP+4sVjwK2Qmym9cMwTOiNhtJTnstF9lSXxs3QY9CY=@vger.kernel.org
X-Gm-Message-State: AFuF++m24uBgZ+yB86gxWtV8fvmrZyllmjYxKrMsS6u3iwQMSCf270uX
	d6RrdPUADL1SKnq24OYaSKZPgeeKA8fRiVI8kh6AMPTae0DI4SRc9DZA
X-Gm-Gg: AYBFou0ZZlnJwhpd1JuyBL05gBfKIWDeLf1Cfmd177Mc9mce6uv7mdKR66fWs2xHSxo
	tnVWrXVYmCountGuXNzmyRl3W1QjxKo8ukcnlXGRCGPc0aaELAFaaF6wFi6rDxirh1jgjQy9Lco
	MSFZYZotK5gJY/tdG7wkYsE9ydevHFgzDRPPqf2lLPeunL+g7yehw5u7UbYFee+aszPtDan+Xob
	mhUx5r3PfdXK3Jj6rvNC8eTx8IUL/Bil7AKfrypZYzB4CtakSSNnrVkYf8s1NNa76r/6VetOhhR
	0qIHc3R1jBcJroPv+TIO/czv7duDHeOOddKuDbnjednFAuQUJfTqQoonh7L/7nR17VBtaLxa3xq
	66Sp4a71E8d5mKBP87Trd4lblfUaeLaExI72Nsm/yOswVZVAtH7ISeGYZ/T2ClBWOv7NI+jcmLS
	olwj1j6X9gtEUeXoDieFehNy6OgTPOvyPcc1xsYGL6J8KH0X0X0f7uvLa9ZVbOX40BXwKU+RyC5
	a6UX+CvFbEDa5Nhz6/YrrFm7b38NJOh5/5KrqrAWlXloOT2/jJyz3deDEAmz7nXtZNFTx+VjqY0
	+hcGdXpjMxbBrQ==
X-Received: by 2002:a17:903:370b:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2df69d332cbmr2348995ad.1.1790102158303;
        Tue, 22 Sep 2026 11:35:58 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a517b8dsm155205ad.10.2026.09.22.11.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 18:35:57 +0000
Message-Id: <DLM296AAASVA.3IGQUR5NOALQ6@gmail.com>
Cc: <bpf@vger.kernel.org>, <rcu@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay12@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-2-puranjay@kernel.org>
 <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com>
 <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>
In-Reply-To: <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>

On Tue Sep 22, 2026 at 2:17 PM UTC, Puranjay Mohan wrote:
>> > +     prog =3D bpf_prog_inc_not_zero(aux->prog);
>> > +     if (IS_ERR(prog)) {
>> > +             WRITE_ONCE(rhk->armed, 0);
>> > +             return -EBADF;
>> > +     }
>>
>> can we drop prog_inc and remove prog pointer from rhk ?
>> with something like if (prog->has_call_rcu) rcu_barrier() during prog un=
load?
>
> That could work but we would need more than just the calls to
> rcu_barrier_tasks_trace() and/or  rcu_barrier(). As the rcu_barrier
> only waits for callbacks enqueued before it was called, the registered
> callback and re-queue itself and cause problems. So, we would need a
> flag that is set before the call to rcu_barrier() which stops further
> queueing of callbacks from that program. Also, assuming we add these
> barrier calls in bpf_prog_free_deferred() which is runs from
> system_percpu_wq, it could make this run for much longer than
> expected. What is the motivation for using rcu_barrier() instead of
> bpf_prog_inc_not_zero()? is it the 8B pointer in rhk or the atomic
> operation in bpf_prog_inc_not_zero()?

ok. fair enough. let's keep prog inc.

>> > That avoids an allocation and a state machine on the arming path at th=
e
>> > cost of 64 bytes per element, 48 of which are used today.

What was the thinking here? Why ask all progs to waste 16 bytes
for future extensibility that may never happen?
If rcu_head growth we can switch to dynamic alloc while
keeping the struct at 48 bytes.

I feel it's a better trade off.

pw-bot: cr
