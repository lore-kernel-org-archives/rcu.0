Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897A127B73;
	Fri, 10 May 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349635; cv=none; b=Oz7uTpVpO8ixfSnU3BsRpwS3J5t2YpRptfE81D1/oOGIq2c5fgG0HfCc9DCqOI+rzyFp17iwsS/fZ97XpqHMiQVvEq/1efPI4pwkrpfH2Hg7jghB1FYfHtgScKRESI8jA51T/hgvLvRrIMEfROPtBIPHSF7GUqjV9MQWVYyKTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349635; c=relaxed/simple;
	bh=UHIFISUNsOGDKsrJclScXfJELpLoDAA3NnSvi1tZND0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gSjVjkN3weMpVVk4plRJBk8ARbZ0O2KE0jk/Xu05rgVNNSM94WGV9LyGQt6pj2Pfxlw1xdKGTX6jC4e6EeqmyvPg360L777VVvEjiXuKn5/lo7NZJMiEvXoT8g+220pKVDgQnYsehu8mVAZSUCnenr9bt6oteV713WK7rmV7CkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/tJIqz2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/tJIqz2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eca195a7c8so17655515ad.2;
        Fri, 10 May 2024 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715349633; x=1715954433; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHIFISUNsOGDKsrJclScXfJELpLoDAA3NnSvi1tZND0=;
        b=B/tJIqz2OndL5YTM+MdJxeXq67pWVJYVBKXEYVjM36bhnnegM6X2vFHG8lu9Y7fquG
         0gcDFcANnhvivIyuSZ6bVpGT/VEL+rmhl9roNXmXbZMrhsZ4ZzMYQnCNkQg0joLFw7v3
         JrZ0V2JYNRpcvjHJ+0slVg+AKKK5h5RXTy5Zfx8til+y+9z4rgSUVTnR5BkyVfa+uv1Q
         ESZ/TgPo3Cx3OMwiZqPl5GAnNXYXKvQ4N0/lvCAxKKU6WZUzWKt+0vflNtdrKXqvHa2v
         w9MIQjevqIdTHyXDnhJYFjumkDYLz7rnymabRNxeiqPec3gVg7xy+Fk+UQxWgoPy59yg
         WDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349633; x=1715954433;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHIFISUNsOGDKsrJclScXfJELpLoDAA3NnSvi1tZND0=;
        b=RUwa2FpZwbfMvjGD7oh1zPVmE2yJ//gq/x04X5DhoUcEW+9KViyaPwMIZUQof01MA2
         ZIFxGtF9IV3faI1p6tHHzthvIhZDeOP2bqyi1qwCW61Cmnzg9PGfGp1f/Zd5qkp9Bhk5
         GuLKViyQ+hfjOMEQ4uHk2qtMWiZxDDb+oYJbTRat4cbWZnVWm00QK6B34S15zUe3cfxK
         xqqknd+v1/XRR+/NKolpBM/jEnr8s7+GKBbEuh57+0I3J5Io9N+u4akeD4RNeCzV7AO9
         c2hh8vetipEEQKW6shvThqQHCUjAn/mIFPw4gmdvP5yQPNnrQfV7s6nv7B75jFnlObyd
         7J7Q==
X-Forwarded-Encrypted: i=1; AJvYcCULyM8Z4puhClCLrf38a+Qidz2cX8LN+pyGkpxZQjS73+q1VcURgvm+tUCUjhbFJMSOMET8JOeCVElUG0kCseIys85mdtxMUmnFPUz6IkXtTIiJYOKX7bGlMWRoRcqVOWhU
X-Gm-Message-State: AOJu0YzYNSU7neClQGjAk0/NraYRia+j/vrwU2wAgBGHBoNv1UjqbDgS
	g+JSkX09VGwrk9GJu112d13w5Gr0B3le3lDsLc4teoQ5T78puEWI0ZQZNw==
X-Google-Smtp-Source: AGHT+IH76OIAy2WNyjYI1RIGKVBpMdu/gi2cfiZnfU1Hg2msv02emamQG8kl4MUTOSvigCq2lL/Qqw==
X-Received: by 2002:a17:902:7c89:b0:1ec:2517:3a06 with SMTP id d9443c01a7336-1ef43d2e938mr20932425ad.27.1715349633240;
        Fri, 10 May 2024 07:00:33 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada405sm32528285ad.92.2024.05.10.07.00.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2024 07:00:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20240510113149.GA24764@redhat.com>
Date: Fri, 10 May 2024 22:00:07 +0800
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 RCU <rcu@vger.kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Hillf Danton <hdanton@sina.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5831814D-BAE2-4161-A6C1-5DE1717D1D83@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com> <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240509151312.GA22612@redhat.com>
 <f0a02cfe-7fc2-494c-8734-e5583f42a8f7@paulmck-laptop>
 <20240510113149.GA24764@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

> 2024=E5=B9=B45=E6=9C=8810=E6=97=A5 19:31=EF=BC=8COleg Nesterov =
<oleg@redhat.com> wrote=EF=BC=9A
>=20
> On 05/09, Paul E. McKenney wrote:
>>=20
>> On Thu, May 09, 2024 at 05:13:12PM +0200, Oleg Nesterov wrote:
>>>=20
>>> We can move these WARN_ON()'s into the ->rss_lock protected section.
>>>=20
>>> Or perhaps we can use data_race(rsp->gp_count) ? To be honest I =
thought
>>> that READ_ONCE() should be enough...
>>>=20
>>> Or we can simply kill these WARN_ON_ONCE()'s.
>>=20
>> Or we could move those WARN_ON_ONCE() under the lock.
>=20
> Sure, see above.
>=20
> But could you help me to understand this magic? I naively thought
> that READ_ONCE() is always "safe"...
>=20
> So, unless I am totally confused it turns out that, say,
>=20
> CPU 0 CPU 1
> ----- -----
>=20
> spin_lock(LOCK);
> ++X; READ_ONCE(X); // data race
> spin_unlock(LOCK);
>=20
> is data-racy accoring to KCSAN, while
>=20
> CPU 0 CPU 1
> ----- -----
>=20
> spin_lock(LOCK);
> WRITE_ONCE(X, X+1); READ_ONCE(X); // no data race
> spin_unlock(LOCK);
>=20
> is not.
>=20
> Why is that?
>=20
> Trying to read Documentation/dev-tools/kcsan.rst... it says
>=20
> KCSAN is aware of *marked atomic operations* (``READ_ONCE``, =
WRITE_ONCE``,
>=20
> ...
>=20
> if all accesses to a variable that is accessed concurrently are =
properly
> marked, KCSAN will never trigger a watchpoint
>=20
> but how can KCSAN detect that all accesses to X are properly marked? I =
see nothing
> KCSAN-related in the definition of WRITE_ONCE() or READ_ONCE().
>=20
> And what does the "all accesses" above actually mean? The 2nd version =
does
>=20
> WRITE_ONCE(X, X+1);
>=20
> but "X + 1" is the plain/unmarked access?

X + 1 and READ_ONCE(X) are two read.

>=20
> Thanks,
>=20
> Oleg.
>=20
>=20

