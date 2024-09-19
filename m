Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747C18EFE2
	for <rcu@vger.kernel.org>; Thu, 19 Sep 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728847; cv=none; b=FkBuyeeHy+lx6sY4s7ID4BgMCgvXGyxJOqTKjo8thjQY3bnZUuP+MIf727ECgHDVvIsMkP5x5afrSjNkwCZ1/Aa7egLlPbat8X2Njl54Rz4CLE84ttL1cCeWRF/sEOdHxMJZHlx9c/OQ50nIqA4BxeyWgIWEXV3USE5hvqXtEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728847; c=relaxed/simple;
	bh=SNG+xyeSaoEynPuXvkVIGLs3uhESwYMX8HsRsEX/v9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adpVAwgtntV1jg7kIS3dW3aKNGN5bVrGxzw5W98H1ABTE3b19e4qSfOfOeK1YOIcJt6TwT3G/PWTGAd1EOvPFavoZr7UlgsU4NkuRhAK/K897Pguus9/+9+ae/pQjCt2izBMwpapVv5zvOa5G/X3Ux2xGmVz4plkxM/voWLt+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FBpXoR4q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FBpXoR4q"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so57023666b.3
        for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726728843; x=1727333643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsgXsH5u0tVyG6FNrWEuco/5eRBOsE17pT8NJW0A2ts=;
        b=FBpXoR4qew74P+NGHx5FnOy1d+2XrkGjSmoCp1RDkmrBhmERRQhzEMNK3MrkATAE1F
         fEp02P/0gQNOHfQc1r9PuHFeMxjzXUYEhHvMcTwbD4uzyCO0kwqVcT2YtX1kWW4wRG6j
         SGAoD7exL8okhKmk0uFLU2hY96IIFGt8gyByA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726728843; x=1727333643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsgXsH5u0tVyG6FNrWEuco/5eRBOsE17pT8NJW0A2ts=;
        b=hWesLh1byYiPvEiIWD532h8W7uLKrH9pc3o2s2zCMtJuP0yR2kaeYnfPw8D8DB0N7k
         TNH1haxDocPrppvslOsc1/yZMgMTnJurZtg6qpdsF9X7xHR+xb6NoVwK0BOtr2bCjL7u
         SMTPpwcgC9YsMNeio3dAquZynQa7TJEaa/+5oY1C6is+IB2TbH9znUfYTN9eMbPldc6D
         4pDv6dzkUAQaizl+3DP60XUTXw021v++rtvjIX2bxojzJJOTDeCncoO7ipB0oj2ocYJH
         9Afi5q4xIHUBKCPQUcdQo3WMdPqfNhZFUie0Y8wu9q1lMqipvFsNjFSS/aAVZJW2U/hu
         UZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVItSQsgIOVx1F6v3j58IilpwKzGNeYCJEq23tB/bqz1c1jel6tCaRUGyooTRWT2vj5Qg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/J3qe6Kzx8IPhXDpUvhSCTO15bKwDIagyUmOckOCRJw2eDJS
	YvqZwQQr6gtWFvxXOKJMiac2vSzVnwjWJnuIhnjy1Ux2dlDOrkveC5SedMXRGTkfj0kCltsQf/A
	6r4sY7A==
X-Google-Smtp-Source: AGHT+IH2YeeqPb5acsLwWwuVsDYaQFiqlZYTeZ+zZM6r/ugjT7yUr+6OtJKZQEa4IwogOIJ1cXebKw==
X-Received: by 2002:a17:907:f763:b0:a86:81b8:543f with SMTP id a640c23a62f3a-a90480cef74mr1885117466b.64.1726728843277;
        Wed, 18 Sep 2024 23:54:03 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096689sm680345566b.27.2024.09.18.23.54.02
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 23:54:02 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d43657255so65626966b.0
        for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 23:54:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaisuqVCM/+br7i/MK5ehNUUZ7DA890Sab2JQpOmREzD7LjFn9T+cV/mrmW5TrHE/KK2Q=@vger.kernel.org
X-Received: by 2002:a17:907:9484:b0:a86:9d3d:edef with SMTP id
 a640c23a62f3a-a9047b50447mr2106944466b.12.1726728403730; Wed, 18 Sep 2024
 23:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
 <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>
In-Reply-To: <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 08:46:26 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjzj+WL6uE0J7d4fuiWAygMzTpvZqZxR+yQJm84TTbBCg@mail.gmail.com>
Message-ID: <CAHk-=wjzj+WL6uE0J7d4fuiWAygMzTpvZqZxR+yQJm84TTbBCg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, John Johansen <john.johansen@canonical.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-mm@kvack.org, lkmm@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 00:44, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com> wrote:
>
> While we were working on this problem, this refcount scalability issue got
> resolved  recently with conditional ref acquisition [3] (however, there are new
> developments in apparmor code which might bring back the refcount problem [4]).

Honestly, the various security layers should be a whole lot more
careful about their horrid performance issues, and I think that [4]
you point at needs to just be headed off at the pass.

No  more "the security layer is so bad at performance that we have to
introduce new ref mechanisms", please. Let's push back on bad security
layer code instead.

                Linus
