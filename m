Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185213AA2D
	for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727458227; cv=none; b=ZmPWN8bCfMkxu7dYiA8/cUPJgq+N0r4atoGZep5iPB1Cm9MFWWaiAjhK6BMZzbZMlGMuscqHIUgXGJOb8Me4+D+YGFQADPBh7oMxcjL7Wm21HWc1oIuXnMw9J9R1BKhYaNmQkSPBURv57M0w4BpCEPe0UKKBn5NjM24I6wLN8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727458227; c=relaxed/simple;
	bh=GCk2RsM5FRN762nuUdIVnJyHlR1/BB2s3RYsgpZTJI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkC3ti16ptnZj6if9suLDnpaLj0kaAdaI7pzy+LTYC9/zroW0HYgyUh+zJ/OJeex8bH5br65x5nm3Nu5L+3aJ+gm8zCtArHevMFJP7bwMPC8irQ4zD7uVNo0uPDIN768LOmktE5VOZtq89wMe+IWGaUNkLkCy0X0N5qwIDeXNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dkiD4Rt3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dkiD4Rt3"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so32824331fa.2
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727458223; x=1728063023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pL+eYyAYNBlL0JEzog7gteLEL6jaNxjttyWOz6wubk0=;
        b=dkiD4Rt3rhPXkffUNSuV5oaGZEj0G+4oHaDsY32+xPW0CcuTJ2MArZMtnFGy6Rm4dQ
         g/AEtItLW5dxwFuPS9h+6xLZPmrpafR9JaKFufroDCU/+f0TWNu9GXxvcsZi2OiAexrL
         MIrm/RcfGXN7wvsgMvwvuhgOg8wZ16vJkgXH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727458223; x=1728063023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pL+eYyAYNBlL0JEzog7gteLEL6jaNxjttyWOz6wubk0=;
        b=ujr1Ayr5WMAx2Hi71vJaly04aQ5qpJPTJPVNWJM1TtZh4ZdUIFTvSRph+sNDwmMhhO
         VVXMLB/4qprnfjRdZER30w8uFQy1QPbsMPBBOlhyT7xh4Fk9tc6D0fgBAiBURa2qWLEb
         8IdVm8TiIf0650RmMxIFfyBRWdfdJX2zz5eVl64gfb5dVTBKfYiuevFZQA9D6q9X/wM0
         ya1riViu+ncl6GqRnNz02g/OE7hzMtLvqibAAij8utIk909FP7NSR5sjLStiV5y85wh5
         HBt2DB0B67xQKms9+OcV2r7YsotcMBKTbKTZD/UFGISOycY2AaUx0v3ulEAxcybEOSgA
         l+eA==
X-Forwarded-Encrypted: i=1; AJvYcCVeCchFnp1avtZJioVuKkoMVaAaARU3RU8M8wzKOnx7P30yqXuvDCbf7VEQUd9h36NnH2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNyWiDE8w4toRfjZsnHH+pa4ddY3yOG++ttvzet/D3kUPFVUym
	BXtz3sUCAhCNx1zpHRG/dECia6SXOfitX8+SHslzyQa1pQPXeP4dlMDtzW5nYjrA83muA2PSMmb
	l5meiGQ==
X-Google-Smtp-Source: AGHT+IEzoWkJPEnqTv4ygo7BxGG0K/oO947WSW5qpJZhHgugL0SJkX3UxaIe2nIBBxbd2i6wMe5jHA==
X-Received: by 2002:a05:651c:220a:b0:2f4:f253:ec7 with SMTP id 38308e7fff4ca-2f9d3dbc8f5mr41125131fa.0.1727458222652;
        Fri, 27 Sep 2024 10:30:22 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d45d9eebsm3926661fa.51.2024.09.27.10.30.20
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 10:30:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so32823721fa.2
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 10:30:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTrCBHKUUMC+WowO/LPTAwLsLmqLSQQFFM5dutYrURDwAfe+rBsgB7qG+u/hosLvYWwkU=@vger.kernel.org
X-Received: by 2002:adf:8b1b:0:b0:374:ba2b:4d1c with SMTP id
 ffacd0b85a97d-37cd5aa684emr3408839f8f.31.1727457821824; Fri, 27 Sep 2024
 10:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux> <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com> <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com> <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com> <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux> <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com> <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com>
In-Reply-To: <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 10:23:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
Message-ID: <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 10:17, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The barrier() is ineffective at fixing the issue.
> It does not prevent the compiler CSE from losing the
> address dependency:

Ok. Thanks for actually specifying code.

That needs to be

 (a) in a comment

 (b) the value barrier needs to be on *both* values so that the order
of the equality testing doesn't matter.

> I'm preparing a small series that aims to show how a minimal
> hazard pointer implementation can help improve common scenarios:

I want actual numbers on real loads. Just so you know.  Not "this can
help". But "this actually really _does_ help".

                    Linus
