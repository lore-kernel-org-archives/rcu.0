Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E98CA4A
	for <rcu@vger.kernel.org>; Thu, 15 Feb 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983522; cv=none; b=GAv8UI8SW/ZNMxVn5MwBbNuOXX+GKYmPWLLs+mRh5lA/2BOBO92R48BCdQqslolmdUPnEkaQ2jHoNwfQ8Tsw3U5UBmUro4pE50rL/yJu7G8scC52Uh1z5ZYXzIxT5j7Xqj+3xTAoOcTAW1RYp6cNEvCY8CzAhxRptT/oAv4P4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983522; c=relaxed/simple;
	bh=JagiqCTSM2R4n2SFaa5xs4t2zy/Vb2TUdw+4Zs1SD0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8TQ1oP+hhBqpezTYTLGdEkH8ET1X5wWRXbQsHKG5ka8vAzJbbE+8FkwFK3ASlrhVrfhLEd6qa5yjfpwYg7VA4fO3uat/5d/epizGi6NFhmFgtUtD/1XG8DQvlZ+mfbD76TidzPOeUzgjcs9uxwU40i5508Fb8y078PdCgzsHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=R/ObZ7zV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="R/ObZ7zV"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 010BA3F670
	for <rcu@vger.kernel.org>; Thu, 15 Feb 2024 07:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707983517;
	bh=JPm/8/iJFUBFVrsO9nWRAZDh2aBuEdQ7oHrSUPsKEFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=R/ObZ7zV+A8yvydugtSqhF2EkwVSXvaRaG1svoGECqWn1mLmL3/eK7lWYPBVxAcR2
	 4noCKEhhp8B6+AvV/kpda0Ek6MEpa8sjFUoK3jIuAPVNK8OH84NPvXIVtoNS7dIpep
	 t64NoLJnsFzelcinF8fL54GsTkvJBKSvHX4iJfOeAELnqrGKQQc2zod/R+O4DZ+p5D
	 1LyM0KrBxHru/hjIQJOyAxJ8/SUJKx2RTwaKCQBo2DBhbW0atTQt9muDDlhXe/ASeq
	 ixjR2qk2RBrVTHG9VTZB7I16Z5JUAMWOPwQr/x1w8wTAgVu7snUUFtAyu97H4bI+3v
	 Lopnefm/apC3g==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a30f9374db7so164801766b.0
        for <rcu@vger.kernel.org>; Wed, 14 Feb 2024 23:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707983516; x=1708588316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPm/8/iJFUBFVrsO9nWRAZDh2aBuEdQ7oHrSUPsKEFU=;
        b=ThC8gOdwC0KPeswastLkDHopx2fGeASaAascKH7YQJGpWq/FRZXV5qG9QWhJnrbre8
         Ev76uKZuAOBGyLsZqW9cFik/n24Ljuk8geOwDdz6ZAMgqImstR9Kn/6PBskk3QIaYopa
         MSk3BaNSceNVpr0zKr0gHJIGn1cNEsxppRQBet4vqMZrMbQ4FLkM+6AkcFkRL6jKF4X4
         V0tQwuct12g6sZzjflU/WdKsMtMRThBJiU+XyEvFIxtMEJQD0PHiH9m6blt/7AQZKO80
         ux4lMAtwtfBIL9swI+SQmFpD9oI2ekNzGctwpPqgd2xk6ksd6aShkVkS/NUnUhuZGD1B
         RBVA==
X-Forwarded-Encrypted: i=1; AJvYcCXiXxVPhaVUnjNvMHNEahwrtsWZXyVj/KM61LvSmrqJBrZ4OI7g/Fv1fmJrCQQTGHyK3Yjwowdp8SCH6h1sSXF7H1zB
X-Gm-Message-State: AOJu0YwIMwNqcYbhKSaPdRPQSLzpCokt9VNT8L8u9KdHI27R269Z7C7c
	LtufZE70irF0AjEdSuWMFgd9IZpqezE0dk9An4/Wo9S38+tvQb/A8goaK6O5IY+GJqNUm1INO6F
	6FXGVexC4iXeKrxZr7WhLRypwvVnF5y/pucZjbEx4PIGzVn2queTvAw7FzfAnT4f2mQ==
X-Received: by 2002:a17:907:d17:b0:a3b:fe38:343f with SMTP id gn23-20020a1709070d1700b00a3bfe38343fmr4314466ejc.29.1707983516708;
        Wed, 14 Feb 2024 23:51:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjEalTZxKiatreRlau14uRmNIep/P7PNUiyn5bN+75i1KfT/mHr1W2bvlR7hcUjZl3S60U8Q==
X-Received: by 2002:a17:907:d17:b0:a3b:fe38:343f with SMTP id gn23-20020a1709070d1700b00a3bfe38343fmr4314451ejc.29.1707983516338;
        Wed, 14 Feb 2024 23:51:56 -0800 (PST)
Received: from localhost (host-79-51-63-186.retail.telecomitalia.it. [79.51.63.186])
        by smtp.gmail.com with ESMTPSA id tj2-20020a170907c24200b00a3da0cecc10sm133112ejc.118.2024.02.14.23.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 23:51:55 -0800 (PST)
Date: Thu, 15 Feb 2024 08:51:54 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <Zc3CmvuD79umJXQv@gpd>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>

On Tue, Feb 06, 2024 at 10:44:33AM -0800, Paul E. McKenney wrote:
...
> > 
> >  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
> >    return, respect to the other cases (is this expected?)
> 
> This last is surprising at first glance, but I could be missing
> something.  Joel, Uladzislau, thoughts?

On this specific point, I repeated the tests with the latest 6.8
kernel and now I don't notice this difference anymore.

hrtimer_interrupt() time is always in the range [4K, 16K) ns, both with
lazy RCU off and lazy RCU on.

I don't really know why I was getting different results, probably some
noise triggered by something running in user-space...?

In any case I will update my old post with these new results and I
wouldn't consider this an issue for now.

Thanks,
-Andrea
