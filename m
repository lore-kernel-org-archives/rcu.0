Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E81494BF;
	Thu, 23 Jan 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673256; cv=none; b=oNHLW9+Qzp3KYh55hvE/OJSKa7ICbHaq7FAnGfQjlXnZmeqijXJsAjtoEXdyecwzYH9bO8ZhzSZa58sytfgkBwP2/Jhfhndr3p7GormPlwxAVgNCuMyp082tw5evIc5XQ8HCuq86+gdQIuVApk5h7/gjJ2T7jAhzQeXwpfdTuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673256; c=relaxed/simple;
	bh=5AOBRZv1qRghXlbYP2GKzyHDkB0WG+ypY2smUohe84I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBIqYNzqQl097VMVIGNBRhXVZaBzdM36MrE/ZcUxUw30O4dmZfPxqI233lGTYylOIYqffTVEMUq39Le7WBxflDMK+dCxNeVOdyKamnfyM/e6KcMsSGdirLMtgr4jVdb2Y5D4HAC0F7C+mqjgoTkWTagGSChQz9mMJ6eIj/WFM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg2SHeS6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg2SHeS6"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso2694970a12.0;
        Thu, 23 Jan 2025 15:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737673253; x=1738278053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5AOBRZv1qRghXlbYP2GKzyHDkB0WG+ypY2smUohe84I=;
        b=Tg2SHeS6ymWWJ+2SNjK6UQfDDb2DzoL8EhzPhgUoBOzAiRq5CIFsr5m5ykHEUrpkPI
         FMktx6IWNXFAZu5s+q/eyXb5MdbdEfDA25gxBWh6ykGO6g6JTsukbF6uhhmQIXZYRj7n
         8MlJSU74bhtpFCRPEhZKLLvL8N48NnbUao81xsPPw7CDlGtM6CVjxtcpfAiqYaQceXiJ
         WfzQyLZKww8N9MwZYVEJe8Oijg8W2WHuxx4oEZZlyW2eIiNp4Wwthl5Gw/EcX0fh+QNX
         eEEl1aBS9uVi/HFw0ZRZWuJruSaucqgRZDevd1EZULBdh58xHWiYbj+K8z9NSFcU2yKR
         HKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673253; x=1738278053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AOBRZv1qRghXlbYP2GKzyHDkB0WG+ypY2smUohe84I=;
        b=aF4zyxDYKIxophxhbtDEF1J48Sh/kBT0Yg7iiiaB/Bz4904a3Oc5XFPjEtHv+H9Dcc
         oxjlrRK0j/Vj4ZN2qfXhiLIsE/Mr0LvfrEqmgnIB4O+2pSidWsdj3ukpo7xyXtO9iPfv
         ihHmFuZPY+0UmmhrHS7jUsUBml1fpakfFGAq2HkQuvHD0iiopzQl6cWsLpvZjSF3XU2A
         qlfZhqw7XEQDm2OyC8J+4YP6b7lWfhMDP9dabvruPcSG+QcgIh3VisugdxmOtxbJzhS3
         6M+BgAb4GShLODkC4uDVkBSYJ/7C5aqXpz3NcIs046rZjid4Zzf/dmXW9kkKAl06xTKM
         woZA==
X-Forwarded-Encrypted: i=1; AJvYcCUcJmwqo4anjiLHee2MPyARkVs7XEQ8Dh48K3FLtbB9eDMnoXXpib4sAN9+ifPacHJOdetM@vger.kernel.org, AJvYcCWL0jnegl6/8zSi0PtdS0y+NkhD9/YAOF9VeXSiwBSgNVMh83PYcig7ApqAD6QOkaU7n/5rzpdR6sbqAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwzinPRmO3OyvP0uyB/0hX/4Z/fGyUEuHPSL/pgyPY24rszPL
	fnieutaWBlIW3BDMtv2dAbrPQhR79XnoPc9T0AItXgoyuOW7SIIT6KX41Np8MNPDrGMQxEdNBwp
	2bjgno2hlyuT/A7+72i9w/fumMYc=
X-Gm-Gg: ASbGncuPfg/yFGMS0tMV/gYTqLck/+JnfrB1Kfjvr+2Kk4vTVs1k8HP3Tbc7pdHA8GN
	pd06Oy4cJoxdiRf80qa7Tn/nnWFWs/WFOHyf3RgJH2Ex7cShdti/bzwad9sieFBc=
X-Google-Smtp-Source: AGHT+IEDJTdPLsz9Jk+YOzqLflcCl5JI/U+reOFvCdkny6W9546g5uZMwbkic9sfhDlOAoQbZQtjLKyPFXYfhNxbg0M=
X-Received: by 2002:a50:d58c:0:b0:5d3:e8d1:a46 with SMTP id
 4fb4d7f45d1cf-5db7db12cdamr20593079a12.30.1737673252527; Thu, 23 Jan 2025
 15:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute>
In-Reply-To: <Z5KMHoA7GlHJyUU_@minute>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 24 Jan 2025 00:00:41 +0100
X-Gm-Features: AWEUYZnA-hfjFcAuzif3rLzelAKE9u1BiodramxAowrFi5Txa0wDJxGBgXJ_bzY
Message-ID: <CA+=Fv5QkJi19DRhUu23hmOcps8Wj2_a90TLfBrXN47ceJ2we+w@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: Ivan Kokshaysky <ink@unseen.parts>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> In fact, it's the odd number of longs (29) in struct pt_regs that makes
> the stack misaligned by 8 bytes. The patch below works for me - no more
> oopses in rcu-torture test.
>
> Unless I'm missing something, this change shouldn't have any ill effects.
>
> Ivan.


Very nice! This seems to do the trick! I've been chasing this bug for
quite some time now and with this patch it seems to work! applied to
my systems and no problems so far. I was looking at a mail-thread
working with 16-bit stack alignment on x86_64 and there the solution
seems a lot more complex than a one-liner.

/Magnus
