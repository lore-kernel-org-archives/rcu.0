Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE9176251
	for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465773; cv=none; b=fhj5VL7IBZmrndDGenHO9UJab0yR4FdgU+xjDUBeApRjDMYNeZyjTDqJmweRAI4bkgaX6M146qX8PakXHfTKsdt2cX8tldsCbJFKx8VabTnA8oP+E6eKVjeSVg8gRBcfhP1PGO2WZwgEbjrDhXl0inSR85b1Li6aPpK+beqRxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465773; c=relaxed/simple;
	bh=kqt5Jntn1aPjnEibEghCyVBj7mxRi2cdnuwUrSdPgVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpEeflEWxnrC3WCBHI1bJfSXFoIBraqYf6b34gOXwuKVzVn/L05Yb9ZDAYOcpIiZ8QtAeZzGJuiCXBuD9YKaI3LY3V1z7w+dAyepNicSAvKfNdI8Kp/WNnR4kphH/tPFQ57Fixa2mPMbbObkoeo2AIR9LE1YZLbdZJhf4+Deaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HKTfrxpq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HKTfrxpq"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so3075454a12.0
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727465768; x=1728070568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4BYeztFGhrhYHEtsZ/kMOwsZ9Tbjy1c0Mm3O/TMTIo=;
        b=HKTfrxpqPu5n+DdYtotNACi1QLIjrovj7NqPsZZtW8pkbIf+0Fwb4BjXYIBb7ztblb
         80GJRAXyG4if0SymO9XfouedXZXQ+UKlEGBxuHVf8GRxb1eC+Lj6IwuSJDXaiiHOE52k
         70llxaDq1CyL/DjDSzLAebw9CnmP41UKiaRF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727465768; x=1728070568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4BYeztFGhrhYHEtsZ/kMOwsZ9Tbjy1c0Mm3O/TMTIo=;
        b=RGf/fBrdZVGU5N1tkfsxv1DbFnqzPpWcQRa31qmGfxUuW/VfnfdGys7yKTjHTgFWDo
         BYDzY19h4vguZ4mkdLCg1pOEH/6hVLxghR6fqM/amegsfO58mFvpvyVb+G3mXoLwTTZp
         x5k+VvxhrEByO8BxmrQiTHj6dG+MWZrEHoxe0UleOdq1EXgfzrUPX0ZPtc1X4lSrq1e4
         Aik//Ssk9pXX+EZflbRCPhdLL/XuL1ksex5BNClO13V2Nbv2Ua8Sq15e4HTlmu4UrlYp
         n+1j2vxQRVXeES5CI3EUoVH4mxfTHP4NiwDICGBkiNy0Bk/44a2ZQDtKa8VnbP8ClV87
         Jqyw==
X-Forwarded-Encrypted: i=1; AJvYcCV3QmxTTd9Vq/JTGzL8KR1K6pxVyo2W9sy2AMiLA01PnmwxyOFq9oB7o5sTqsVc/fA42N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyni9hDdqMPnf5eeqjOE7SQwBfgrW2HdVvF05kkGFlKaxqOL5vb
	q71SsW5Y4j0xL5VBH4JnGJAz4sW0qNMPNm/1k7a5tJTjAb+PWtJj9fDBBXqcIrJj0XR8z+JHl77
	gUEEMHw==
X-Google-Smtp-Source: AGHT+IGHMdB+ufiH+RXR+f09HIPC/Jqg/q6RlPXqPi0g4unzN4gHuQd4VmKbaEI0K+upO8LuVl2qlA==
X-Received: by 2002:a05:6402:280d:b0:5c4:23b2:ec35 with SMTP id 4fb4d7f45d1cf-5c8824e5166mr3839007a12.10.1727465767992;
        Fri, 27 Sep 2024 12:36:07 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882493e54sm1461388a12.80.2024.09.27.12.36.06
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 12:36:06 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c874f6f119so2837716a12.2
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 12:36:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAihfJFx9lGKgSNYETZICaOWHQRKPnXjDG7K0zFCbfjHo34Nr4Ha8X+4nSfjdBhQBFeIo=@vger.kernel.org
X-Received: by 2002:a17:907:36c5:b0:a86:7514:e649 with SMTP id
 a640c23a62f3a-a93c4a69d42mr423065966b.52.1727465337418; Fri, 27 Sep 2024
 12:28:57 -0700 (PDT)
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
 <1b04e35c-8994-48d9-907a-966bb4dfabaf@huaweicloud.com>
In-Reply-To: <1b04e35c-8994-48d9-907a-966bb4dfabaf@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 12:28:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
Message-ID: <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
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

On Fri, 27 Sept 2024 at 12:12, Jonas Oberhauser
<jonas.oberhauser@huaweicloud.com> wrote:
>
> I think it depends on which one you hide.

No.

Dammit, people, read the code I posted.

> But for
>
>   z = a;
>   hide(z);
>   if (z==b) { *b; }

No.

I *intentionally* made it an inline function, and only hid the
arguments to the equality comparison.

So the "hide(z)" hides the argument to the inline function - NOT THE ORIGINAL.

> then it would still know that b == z, and could replace *b with *z
> (which really is *a).

No.

The hiding is literally *ONLY* for the comparison. It's inside the
helper function. It doesn't affect the originals at all.

Which means that the compiler CANNOT KNOW anything about the original
pointers when it compares for equality (or inequality).

Basically, the comparison is now a black box to the compiler, and the
compiler cannot use the result of the comparison to make ANY judgment
on whether the two original pointers were related or not.

               Linus
