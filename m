Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550115B54A;
	Wed, 23 Oct 2024 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666705; cv=none; b=L6phBONUZ5Y5A0PmumJqQKo1enTOILlMZuHgJ5ihLkIaYLNIeF2/ODom82pnAS7ko3LyxYZEV2gwRMozPa7erHkQGaWbUi9/iOCS9GhOg7O0XhuUS88PUExvh24r9pNhMIHwJuuR+ne+YnsTGdy161cExHW73N/BAVuM/tLZBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666705; c=relaxed/simple;
	bh=kIYSP2HrvnlBooroD9bV1HBVuIhQtKeyM8zyzFbi0Dc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F7DiWYsZkBaGVP//kPGXUXqk2IB0M4cpg0KG9RIOhlPwRDNaGmR6SzaDK1WjWQP8tskFgjn/08PFOBMOVKgCLGaQfuqHFlwLjylYIA0grdsnXehDJjnveunjIMH6E7gWeyyEO5tTMJbeDceSrn+y74wNJgfmPgUknczhRCCTWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5+4mh1G; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5+4mh1G"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so429959b3a.1;
        Tue, 22 Oct 2024 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729666704; x=1730271504; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psxO1zt20+uv/LX4GmwC5XIGZqa8nVpZ7UFHq/pnWwU=;
        b=P5+4mh1GQhu6Uy8jhrHso4xmMb9AeiQigUCvp+t+ND7ADRRZtyNa3Z6g570jRLHX36
         2tG4uEerlWUXn1QhsrbaIevAB9B0M/gRM3SOWJveCaTjxw8Ygb3WW7zEXLZ4OHSD8r1M
         57NaiKJAdSjwUx3wQGuJI0PQoQS6neJ9J123rP7k0pzsglHkk1DW3CZ6b7RbvIReW1cM
         q60W1GL7AAiItPEE6zXOUl2Dv6wWSYY4LVQUl1Ek6E7NbNkeU6KZtKuiEtIHBPgYFSG4
         UG3DoGKAWuU1LAacKJCLpbTt6o1qrBs4eJfgN+8Lk47uy9fQvcpV15xjnYzt9XYqkBLq
         xIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729666704; x=1730271504;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psxO1zt20+uv/LX4GmwC5XIGZqa8nVpZ7UFHq/pnWwU=;
        b=XAvvJ5Aq/BoUkhKL3VPmQDii7LcJO1KdzWr1p8RG6ebsTt039Zjn/hNp9z1AU7xyQt
         lRFfqYTb6exT7bA+sZPRmCwF2nayUVN7ejAOT3xZ5NGeGPpYGwjocDAiMRmxbetoXQ/h
         vh5ZIwPdzjbD+MDRg2R5nCQ0AvN5fCunVZSPYs/FSnbLOAKhiYEy1oZAmAsp5M/INIES
         4NYdaTwldthJmzrtk31IVx5MAjptXU96Qc9bmiHEqwlslaR+l0cRA1lW6GXvHvwF/w16
         rRg/VGzceBMfISYQr8YuRFgN6saYsqgl0UHwX3RAfY8QjpCwlZj04VgWnQ4wXN3GyeYh
         t3rg==
X-Forwarded-Encrypted: i=1; AJvYcCVZIwsDqE1pdX3kiKJfP6m3L4HKZPOd0ebtfqbKKGlLx0Votd3WI90l+hhc3pKgiOHKNa1TIWYprXjOeLQ=@vger.kernel.org, AJvYcCXoFLj1/qOGq4faqH7MWYfqL+jzpu7fs4XEizV+DWyB+sPSY8GOHNygBbu/tYNPIYjyvYKn@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfJKqzwNzCOPBB1SdePdbK1QWxOYjgRZw0rpYTOrPc4/44JyQ
	e7XsTxwfkZdNoXz4otT/E/3DYI2HhtHezV+VO7W2BMzQgwkuthgF
X-Google-Smtp-Source: AGHT+IHT8m3VszuaXVMsEaYDU2CFxrir9D9o3wCZ851AbCNsg96M3hI28FV72+/POnMqh+W8gJRxig==
X-Received: by 2002:a05:6a00:2d0b:b0:71e:74f6:f83a with SMTP id d2e1a72fcca58-71edc132db1mr10191008b3a.3.1729666703550;
        Tue, 22 Oct 2024 23:58:23 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea28fsm5904240b3a.141.2024.10.22.23.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 23:58:23 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
Date: Wed, 23 Oct 2024 14:58:07 +0800
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel-team@meta.com,
 Steven Rostedt <rostedt@goodmis.org>,
 andrii@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E068D091-F79C-4F56-974D-08ED95AD6F58@gmail.com>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
 <20241022071018.GA16066@noisy.programming.kicks-ass.net>
 <ZxdQiLhn16FtkOys@infradead.org>
 <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
To: "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On Oct 22, 2024, at 22:26, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> On Tue, Oct 22, 2024 at 12:13:12AM -0700, Christoph Hellwig wrote:
>> On Tue, Oct 22, 2024 at 09:10:18AM +0200, Peter Zijlstra wrote:
>>> Ah, well, the thing that got us here is that we (Andrii and me) =
wanted
>>> to use -1 as an 'invalid' value to indicate SRCU is not currently in
>>> use.
>>>=20
>>> So it all being int is really rather convenient :-)
>>=20
>> Then please document that use.  Maybe even with a symolic name for
>> -1 that clearly describes these uses.
>=20
> Would this work?
>=20
> #define SRCU_INVALID_INDEX -1

Is there any similar guarantee of the return value of =
get_state_synchronize_rcu
or start_poll_synchronize_rcu, like invalid value?

>=20
> Whatever the name, maybe Peter and Andrii define this under #ifndef
> right now, and we get it into include/linux/srcu.h over time.
>=20
> Or is there a better way?  Or name, for that matter.
>=20
> Thanx, Paul
>=20

