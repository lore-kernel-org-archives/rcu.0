Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF43218B
	for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468669; cv=none; b=q8g7+Daip5UtxlXR1+eCk1ax+kAa6gf2bFj19lYbzHNGc8swtvoHlsNDGXdXG0BQWobrkHoFQmDqZ/N5BmCIFOmXIqrKPP+15rHhcaXX02tgKBmokARk+dWzwbzd/D3q/1oWAqc7aYSvL2foJ/JKbH0c9FqIEdgvk2xP6e8e6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468669; c=relaxed/simple;
	bh=DktPPQWVliv9sw4BrPAGhW6J9QwXUF8Rr4uJcTFsAy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCtNN+VH633/GxDfpeUAGZjZsuF+BsDnl/rKr7ZH6l2Hhhs8JiZKBiBLM6UkzNrBltMlIk5LSu1awF2GFbG9iCcEyfA7gyKFiwYx6C3tXSMPHWZnbwULTDF98Dvmi6x1xzPi3+SVI3UX4T8TQzxT9sLWPcU9gszskAmOimPwNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EXIyisXQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EXIyisXQ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso4063354e87.2
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727468665; x=1728073465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7HnKDJ0lmmcY7Bm5NjvF8jzj2uLye3yGTiI+8Ax554=;
        b=EXIyisXQQmXh4rUX7lBd0BPnS9FnoNa2DU9SqVWPTFnlE5PApL4nnSwlqtvJHgqdm1
         Mvbz6kOrgQzmWR/djUUV+3KPFzJsL9ZilSXH0kjrJLWoHgyhK1B9OeEF5kIhsA19Jsic
         6E92tkz5DW8y8fYoLVa4tXGJB8HI+gmZocDxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468665; x=1728073465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7HnKDJ0lmmcY7Bm5NjvF8jzj2uLye3yGTiI+8Ax554=;
        b=iKDgyawuGJqMACW9swx2X1tjzFCkI7/d3/v53YacmbVZL6seBoexCyxnRIcRCe33pA
         9CwtpwHRWFNj2x7vONVCoU4ot6XLemyM9otIyF96hfewYZ8vEKc0c+L0/mIWTzJwa/3o
         wEpa5gGw4t5cwyV1YjzFGhUwjLJX6B8mtjr3HpKJIirhBBX4/QOxttUxwQJ00AfKl1I8
         4HM0llZcliNXBN592lxvp5VMJp5Jh9420btslUJhI8jrn9wAW+H4+ZhFuI3gQxySEv+x
         3p0RVztSiTgPtffW9L/udfdwaqx65kFFfrFHxtBoPiU/5VAus//PEUNhZtCs9QFx826W
         SZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx40vKf04gubb2+goxUOiljr7/zXPOaDktYQuMvubfJdZ9zjJvM36B0gHYGfVGE4/5dJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysV2ODUiVthzrS2fL/jsNZEnEZOC+4i9DM6Z0kmcryzmhK7od9
	U9mhIso4vbDk7ymPfdSiqMbwECBK271qzbvral4p67l6NJGc9EOKTGhEtXmzTixk666g62G1eSO
	je/aIyQ==
X-Google-Smtp-Source: AGHT+IFneWVE806niHvblmlxLSN2/BSpxv56TX6eLtHDRQnFVbBwwUclpxOBZ5HQo/HnLTsdc+gOjw==
X-Received: by 2002:a05:6512:3d8d:b0:52c:9877:71b7 with SMTP id 2adb3069b0e04-5389fca4475mr4289929e87.59.1727468665499;
        Fri, 27 Sep 2024 13:24:25 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0443215sm412510e87.282.2024.09.27.13.24.24
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 13:24:24 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso15321661fa.1
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 13:24:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn94KvAB6/MNwotl4xSY84yX97QrQGbtdsITN0xrSoNo816pIs4lDYHaS+TH8h94SMEPk=@vger.kernel.org
X-Received: by 2002:a05:6512:3095:b0:536:a5ee:bb75 with SMTP id
 2adb3069b0e04-5389fc3f106mr5002054e87.21.1727468663689; Fri, 27 Sep 2024
 13:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com> <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com> <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com> <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com> <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux> <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com> <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com> <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
 <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com> <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
 <1b04e35c-8994-48d9-907a-966bb4dfabaf@huaweicloud.com> <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
In-Reply-To: <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 13:24:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whteT=CDW09TMk4wwwYs+qvcAKQUfw8+1D-e8H4XhFs3A@mail.gmail.com>
Message-ID: <CAHk-=whteT=CDW09TMk4wwwYs+qvcAKQUfw8+1D-e8H4XhFs3A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 12:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Dammit, people, read the code I posted.

Actually, no, apologies. You were right, and I was wrong.

It does need both of the sources of the comparison to be hidden,
because while even hiding just one side makes the comparison result
"meaningless" as far as the compiler is concerned, the compiler will
still have generated a pseudo for the hidden value, and might decide
that it can re-use that pseudo for the non-hidden pointer if the two
then match.

So yeah, the example function I posted should be safe, but my "you can
probably make do with hiding just one side" was actually a bogus and
invalid optimization. You do need to hide both sides. Not just for
clarity, but for correctness.

             Linus
