Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04451C173F
	for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460809; cv=none; b=I8X9Q5uq+U9QjSZ3qtPmpSaPZriTBnPLO4WZK9EVLNtP5NAUJttEPQplKm1j9hQrxsUw1D6QLLAhBvHX/5WnBGCg8+pikMfLBo3dINl0fVcCO96z9s+rqOkh6/rGaFSoZfIb4reeWHEPbgt8XQB/7Lbuxj8+c/O/8MM/3G/ICLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460809; c=relaxed/simple;
	bh=07wSPeAgU67g80HqM54Nnsi81+Gz526YFvVEU0VUWqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJSyvFXXJoAIqLHil7Ev/ga4k1R0EVKAM73W1Q6qhH+/DtD34FaEKEXe8IJTFAU0e3SPbP4/9fs44kRUCt2hGPP+55wc9NPxPniFSaRumBNsuPyacZGTnGb5mu8vH060vdp/xWbVKoSKKTn3LlKNLrL2FQy2gmmtgifGSNjIFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AGPm7/vc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AGPm7/vc"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3057059e87.0
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727460806; x=1728065606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUX1kCLvq6+bfGUvOV4xSkP3/ox8tqlvT0bJqmyP1AA=;
        b=AGPm7/vcRWufVxXke0IUCryySPsm7TT+qIP+/KUjZrQ0PQRG0wr6ncY7xq38k2VR9P
         rqz5KKzkoyjXe67fdAlyuXpMRLG32zOW54YBvCpuxb58B5JYBV98+075o2xt4MwztZ5m
         5wC23RmHoj+JtlVBGziDt7gUpkRH85r+edRV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727460806; x=1728065606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUX1kCLvq6+bfGUvOV4xSkP3/ox8tqlvT0bJqmyP1AA=;
        b=lYtw+12YthO33KsziQPSHpfUGmZgFX8fhMn9pYqpiU6SMmPh1+/yUPEy1O3DT8EXtO
         CxVawYGr5sO9hEv/LvyeBEHJUPRfArJ2KWYsHEfQ+7XPlyQ3o0fZB+B/lHKQ/MOMw8QE
         1uj5aProtiDevg92Kyk2VZH+7VCReYOif+QdRBaPaS2FEzN8ychOj59zXiot6Da1+u3Q
         3FA8OD2gmo4U16tK1RoAQeIWCqkKZs9/SRf4zvSz3JDj4HyEiMrdpDh+WjM0wXo4IELH
         OVGmhGIUGKRmZb474N9DzGS/jCaGZyEwLDPjNCkpZFp4fxtGoFAOL/BNDZPx9PXKiE3Q
         E4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWNW9jO0mwe8hTe+OcpK3B7uEm/F3uvTi6RBzzvVBZ8D+qNJ8SpZJbmZVxi4zeCAI2vkqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsthksj8I+L9sURr+vTFcDxUctAERwXZZeYhpI6qiPTmDj2FCl
	BbL+z/yAYzr/M3XztCjfoguQbJ4MyHJTqkOgW3+4VOO8ozvnF9PrPr13833xvgqb76tj/9Eay/z
	wMk1+sA==
X-Google-Smtp-Source: AGHT+IGykDdsO+t9YkrTJrZjCPjYotds5StRJnkW/ZXdlWs8HcwUBkUivgrHpVOh1XPC/LYNcUQwLg==
X-Received: by 2002:a05:6512:1095:b0:535:ea75:e915 with SMTP id 2adb3069b0e04-5389fca4225mr3984117e87.56.1727460805549;
        Fri, 27 Sep 2024 11:13:25 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5f528sm388255e87.96.2024.09.27.11.13.23
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:13:24 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so33308161fa.2
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 11:13:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHu+BMyk8VT1ajGrPYVrZA2IXiito2TKiYdM+Ys/VV2rzliWVsplZfQyzOq72iPTVw+AI=@vger.kernel.org
X-Received: by 2002:a2e:b8c8:0:b0:2f7:562d:cb5b with SMTP id
 38308e7fff4ca-2f9d3e3d465mr41944381fa.7.1727460802851; Fri, 27 Sep 2024
 11:13:22 -0700 (PDT)
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
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com> <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
 <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com>
In-Reply-To: <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 11:13:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
Message-ID: <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
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

On Fri, 27 Sept 2024 at 10:53, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> >   (b) the value barrier needs to be on *both* values so that the order
> > of the equality testing doesn't matter.
>
> If we use OPTIMIZER_HIDE_VAR() on both parameters, it indeed minimizes
> the odds that someone get the order wrong, but it disallows using
> ADDRESS_EQ() with a constant parameter

No it doesn't.

This is trivial - just hide the source of the *comparison*, so that
the compiler doesn't know what you are comparing, and can't use it to
then replace one with the other:

   static __always_inline bool compare_ptr(const volatile void *a,
const volatile void *b)
   {
        OPTIMIZER_HIDE_VAR(a);
        OPTIMIZER_HIDE_VAR(b);
        return a == b;
   }

compares two arbitrary pointer values without allowing the compiler to
then use the comparison result to use either of the original values as
a replacement for the other.

And yes, that "hide both" model will cause a bit more register
pressure, because the compiler will now compare two values that it
really thinks are potentially different from the originals. So you'll
have two "useless" temporaries that contain the same values as the
source pointers, but if that's the cost of having a comparison that
the compiler can't see, that's fine.

Making it a bit less obvious, you can hide just one of the variables -
you don't actually need to hide both m(but for clarity, maybe you want
to).

Because even hiding the value one from the compiler will mean that it
can't use the comparison to decide that the originals are equal, even
if one of them is unhidden.

No?

              Linus
