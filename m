Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7321C0DF2
	for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455473; cv=none; b=A0nbYlpqaQNEdRjUi1t0Qiiwfg+lDND7FblrhkmVIhemHrT7ZxXZATfhYmVe3wQebQttQ+1oLNmRKbJAWZd1qBMme7wlVQjSpAPKSJnGEfH5R5J3AmPT8I1pMb4SSHyT5k6Hi/q/UmnOTAPAg9kfUQxStqUeWKKBaFeM3hUszAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455473; c=relaxed/simple;
	bh=C/61GLLGEEVYHtyByRtDw7pPawa+NNpIeX7syWGrSlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mrt1AZI621//+yswTZRh+UQ0ROl3FgY8QBUqzXNUj3kiPS/f+X7nXayTrrp2+SugjTJl1I0StMJ7V9iC8E9Kb3PH0332F6qrUeL2ZTszlKf4gKQPZ5ZgbzqZHNmw/cyXZKGD2A9mF9gJKXpK38v0f2B9Hg6y4FqFzsjbu9XnhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZqHbmtea; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZqHbmtea"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d4093722bso325433966b.0
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727455469; x=1728060269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPpqzCsLOObKbwWe/AzrIGNw3HOBLR2W9N0IccOsIgU=;
        b=ZqHbmteaT59t7x8Bl6bBV9qGaPNP/Iwph1FfLuoBspZJyL9wtBU2RNIlFVvKLTPNck
         vYZ5h3Nl5IeqUGFY1yhn0NrwCnfr3IqDnKbiHNCKI8UYc9kM2wz/Tk1JSzuWsJDUxvVp
         CHBP1wvMI5Y0HKNW0IwgQuWb4UvHwnJCekEtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455469; x=1728060269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPpqzCsLOObKbwWe/AzrIGNw3HOBLR2W9N0IccOsIgU=;
        b=IqdIbedh54t+AtRMCgUxTPl6HBLeOpt7gnqllKmkwFNgMg5o9REwfEcfYSFTbujruk
         5W1+3mbVUpR1xpBvRxTSOK+sJ1aMP79xQf9csAY81mM4QS9c8rSsoTnxE0n/SndJEFy0
         t5+xiwvixSSNmCG+yOZ0WszskLtpI/P21ptknaYqybXcrS4tv9KNb/JPb8jiApWSm32v
         ywyYO9JFFjJ2+72MNkk5EuZMAjnIWV5dhoWtpRiB8CPzNAkZs/o0JziU52OrYkTNLVJ/
         d3bF3XSgQpRccHXqN9sIpG+w0z1lt5GJhS9Dly+tZfmoFJ9nIjSxix9f4/4Hfko7Pg6k
         iapw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6oAtrrhzTWPpRVAeuO8eeiC3E7Yfx/r+UOSLTY5RI021fbfB+XySiRWj905x1XZdTzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8man5S0zoRRB+8wEnYJw4xnfcLMnIi64ScgGjbLmSixyxAK/
	kYa9BV2Yfy3vTNEigQMgLh21AtBqPxQ9yp42v2DpD9svo6k+sTP+TtnCNYdb8kgS2aDlY8nIW0b
	nC+wi0Q==
X-Google-Smtp-Source: AGHT+IE1w3/mMg7vZwkHkYlFox+oDGtzNieHH5m2FOtUW8HftWvYYqPLnj5I4Il9gjk2V24hRZggnQ==
X-Received: by 2002:a17:907:86a6:b0:a8b:2604:1da3 with SMTP id a640c23a62f3a-a93c4908e65mr332833866b.17.1727455469303;
        Fri, 27 Sep 2024 09:44:29 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5a7dsm153087966b.62.2024.09.27.09.44.28
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 09:44:28 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso340729366b.3
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 09:44:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe9bBI9qL0oeK7COVs9/QXbYvf+rzxfOe26iDOjdfuvohpNNkQZflU2kPoIJfH4guPGuo=@vger.kernel.org
X-Received: by 2002:a17:907:748:b0:a7a:b73f:7584 with SMTP id
 a640c23a62f3a-a93c492a391mr352824766b.34.1727455468157; Fri, 27 Sep 2024
 09:44:28 -0700 (PDT)
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
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
In-Reply-To: <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 09:44:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
Message-ID: <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
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
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 18:38, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Note that ADDRESS_EQ() only hide first parameter, so this should be ADDRESS_EQ(b, a).

Yeah, please stop making things unnecessarily complicated.

Just use a barrier(). Please. Stop these stupid games until you can
show why it matters.

And by "why it matters" I mean "major difference in code generation",
not some "it uses one more register and has to spill" kind of small
detail.

At this point, I'm not even convinced the whole hazard pointer
approach makes sense. And you're not helping by making it more
complicated than it needs to be.

          Linus
