Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA681DC04C;
	Wed, 23 Oct 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702596; cv=none; b=bVOtOwyvsc9cHBRCcJ/cDNZcE1ttgkGHkCwlYfT5o8NpsNZ4pwHw8Pfp1m9Xmr88V0GdLbAQdzBRn4UEmXFDwaTDhkqzQXk+sPOXSpqhfvJnfmrXwO9xKMblaJFOgPfwJ70uYI+eylFyRcJ5fLSZBFTc7LniqzOMbTdm2Yhogo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702596; c=relaxed/simple;
	bh=4Z2bXOVHoOLaYgduJyI4XgEMU9ITD0Z5a9XbRW0abXQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hBxZV4pa8MzmeoAYXAeDS0vdW7SDwVxWDPK90VCJaPKw3R8ECHx184xRKBdYdSRsEtcXucNR/kwfduJ+4vfa7QbSWTk4wEX6tdA7f2jnfyKYP/BhDbl1aszT/iC2o+lIxW3LuMz5JSbGbLzXjTYw/teAy0LcHGgZ1QQvcc7hkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4ten0r9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4ten0r9"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso20178b3a.3;
        Wed, 23 Oct 2024 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729702594; x=1730307394; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIpvrZDI2d37x/zsZQXJeOIOlJk6aEtI8w9Jwx19ZNM=;
        b=Y4ten0r9pWXzULzmu+r9I89eRrFqAjrsNCIvTXq/4NRBAr+D1A9gTLbTTI8KfmHFdj
         I4jFiUk0H+dVd8vhUudzwJiiqBA4rejr+Opb4pepgHb3x3cAzwNAsETi9WcX7ZsPB9FL
         UImBQCllk3K/9iYWKZ+4kIY1uHwePh4qV5B1Si470+ffyPSNIHYUVNqaVg0QdamrhYnV
         2/frok+q6ItQKyeeG60A/unRMFEWp+JqurABZ+xY5DcuW59WWcdlB3ICpZf1jfKLAcuI
         9q7pBNLcxjnRkFWmixigityle5zeLbMIMAfxUpEvAQWWhs7hDy/hYHykU/g7aiUuTB4y
         +tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702594; x=1730307394;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIpvrZDI2d37x/zsZQXJeOIOlJk6aEtI8w9Jwx19ZNM=;
        b=tUef88tjN+7qEiiuZaQhu/gCKpx9tlZybXx8xN3jJYI2X30Qs3DGQwkgb2lohsLcWq
         zDwLr3xSqLeYddd9SXpRyClRw7QKHaNhVRr+UoQxk2Zhkq8DpDz1DqiUwqinV6QZYQ0K
         HAogXcCoOJU+4TftG/8xhIUqtxYToXBsnqj543BueX749E/4BGCU9mm07BnprOZqcKPv
         DpIgHl7brLTLbuB6QdvgQ9zYOP7h69S2qvzKrFWWSd+DQzovkOvvIQbXwIUnk662kSNU
         v8OoQK2rs1B0ZyuEo+oB0lN4SjutThsBibDerCEj7SO22SyJUI3m6rkZz4HzB3U4cJkM
         F2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVRIYsMYDxa2bgesO4xz6MsgJonBRMtQHbcdaKdlrqFJSrfjpMjoRBTTdYgXtW8e9Zt1Abtzv9GnE8EwOA=@vger.kernel.org, AJvYcCWenOzysp0nHvIXEeyRch+NdwiEp7NhuJyi8HMkWrlsIxbp/Iz2oPe6xqYp1H8k8VIwcVDy@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkH3IACjtUF+VoVZJ9YBOXIwFBTbBsjtyqcYwyRIT2Q3lIvOY
	ZsyjYuRjugW6l0tAbOdtH041/2s2ZF6zwXGQprNRK/9+i7MMP4jd341czjr+
X-Google-Smtp-Source: AGHT+IGwZqpvJg3fUolgxw9TqbeGkFqQyPK2EXEyZdgkVMewcVGk38l0ufdqy7In1AL1UwmzuwYjvA==
X-Received: by 2002:a05:6a00:1aca:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-72030cafd02mr4914489b3a.22.1729702593885;
        Wed, 23 Oct 2024 09:56:33 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d6bsm6542775b3a.29.2024.10.23.09.56.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2024 09:56:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <e0bc0674-9309-4749-b74d-e0aa6b40a552@paulmck-laptop>
Date: Thu, 24 Oct 2024 00:56:19 +0800
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel-team@meta.com,
 Steven Rostedt <rostedt@goodmis.org>,
 andrii@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <181BFA9D-92C8-4ACC-BE50-8C752EB9B8E8@gmail.com>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <ZxdLfLWWrAEfRiXV@infradead.org>
 <20241022070635.GY16066@noisy.programming.kicks-ass.net>
 <ZxdPN6wT1LMyLaNL@infradead.org>
 <20241022071018.GA16066@noisy.programming.kicks-ass.net>
 <ZxdQiLhn16FtkOys@infradead.org>
 <8b2552d8-0453-476a-8606-e8b761934783@paulmck-laptop>
 <E068D091-F79C-4F56-974D-08ED95AD6F58@gmail.com>
 <e0bc0674-9309-4749-b74d-e0aa6b40a552@paulmck-laptop>
To: "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On Oct 24, 2024, at 00:40, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> On Wed, Oct 23, 2024 at 02:58:07PM +0800, Alan Huang wrote:
>> On Oct 22, 2024, at 22:26, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>>>=20
>>> On Tue, Oct 22, 2024 at 12:13:12AM -0700, Christoph Hellwig wrote:
>>>> On Tue, Oct 22, 2024 at 09:10:18AM +0200, Peter Zijlstra wrote:
>>>>> Ah, well, the thing that got us here is that we (Andrii and me) =
wanted
>>>>> to use -1 as an 'invalid' value to indicate SRCU is not currently =
in
>>>>> use.
>>>>>=20
>>>>> So it all being int is really rather convenient :-)
>>>>=20
>>>> Then please document that use.  Maybe even with a symolic name for
>>>> -1 that clearly describes these uses.
>>>=20
>>> Would this work?
>>>=20
>>> #define SRCU_INVALID_INDEX -1
>>=20
>> Is there any similar guarantee of the return value of =
get_state_synchronize_rcu
>> or start_poll_synchronize_rcu, like invalid value?
>=20
> Yes, there is a get_completed_synchronize_rcu() function that returns =
a
> value that causes poll_state_synchronize_rcu() to always return true.
> There is also a get_completed_synchronize_rcu_full() function that
> returns a value that causes poll_state_synchronize_rcu_full() to =
always
> return true.

This is exactly the API I was searching for, didn=E2=80=99t read the doc =
thoroughly : )

Thanks!

>=20
> There has been some discussion of another set of values that cause
> poll_state_synchronize_rcu() and poll_state_synchronize_rcu_full() to
> always return false, but there is not yet a use case for this.  Easy =
to
> provide if required, but why further explode the RCU API unless it =
really
> is required?
>=20
> Thanx, Paul
>=20
>>> Whatever the name, maybe Peter and Andrii define this under #ifndef
>>> right now, and we get it into include/linux/srcu.h over time.
>>>=20
>>> Or is there a better way?  Or name, for that matter.
>>>=20
>>> Thanx, Paul
>>>=20
>>=20

