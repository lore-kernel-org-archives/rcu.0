Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3B1757D;
	Sat, 13 Jul 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720891205; cv=none; b=gnAQWwcADqjxuUYokfx5caAQB8l2e8OgR8lQwRbO3dSWwiOa5GVZoQGUxRWg2eS3C3Jtc52F5JqGDJFwdfHsTzE+scXMa1/EmejprmDVarRy5fMfxswgk/NTrK6r9zG7jNtoDjTmEGfJuS+SvzfbFftxCryhbcGi0jvK8u9AOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720891205; c=relaxed/simple;
	bh=5Xt//YVwJ8nURHEZ3A+WnyEhChXU9IS7HnsxEpO+hEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnoNTxDTlfFxR6AMI4tqTulGZZW7RW0wxbgWvKSQonr+JI8cOYGgJQV82X2ZlpDzintHMfjZsmTuh22DoKlNMloXVHnxGCRvLgnh1MJN/SCpBiX6clVAO9BurvGg8OxresvqK5m+88rRB6c+We+3Vdqdj9d+CQMN7uBhsoB2DU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sSgKJ-000000000C2-2Hfp;
	Sat, 13 Jul 2024 13:14:27 -0400
Message-ID: <8975d74f5807f76478ed08206dd5eda133a55bb0.camel@surriel.com>
Subject: Re: [PATCH  1/3] locking/csd_lock: Print large numbers as negatives
From: Rik van Riel <riel@surriel.com>
To: neeraj.upadhyay@kernel.org, linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
 mingo@kernel.org, peterz@infradead.org, paulmck@kernel.org,
 leobras@redhat.com,  imran.f.khan@oracle.com
Date: Sat, 13 Jul 2024 13:14:27 -0400
In-Reply-To: <20240713165846.216174-1-neeraj.upadhyay@kernel.org>
References: <20240713165642.GA215331@neeraj.linux>
	 <20240713165846.216174-1-neeraj.upadhyay@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Sat, 2024-07-13 at 22:28 +0530, neeraj.upadhyay@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
>=20
> The CSD-lock-hold diagnostics from CONFIG_CSD_LOCK_WAIT_DEBUG are
> printed in nanoseconds as unsigned long longs, which is a bit obtuse
> for
> human readers when timing bugs result in negative CSD-lock hold
> times.
> Yes, there are some people to whom it is immediately obvious that
> 18446744073709551615 is really -1, but for the rest of us...
>=20
To clarify the report a little bit: it appears that, on some CPU
models, occasionally sched_clock() values jump backward, on the
same CPU.

Looking at the number of systems where this happened over time,
leaving out the exact numbers, the distribution looks something
like this:
- 1 day:     N systems
- 3 days:   3N systems
- 1 week:   7N systems
- 1 month: 26N systems
- 90 days: 72N systems

This does not appear to be a case of a few systems with bad
hardware, where it happens constantly to the same systems, but
something that many systems experience occasionally, and then
not again for months.

The systems in question advertise CONSTANT_TSC, NONSTOP_TSC,
and generally seem to have stable, nonstop, monotonic TSC
values, but sometimes the values go back in time a little bit.
The cycles_2_ns data does not appear to change during the
episodes of sched_clock() going backward.

The csd_lock code is not the only thing that breaks when the
sched_clock values go backward, but it seems to be the best thing
we seem to have right now to detect it.

I don't know whether adding more detection of this issue would
increase the number of systems where backwards sched_clock is
observed.

Many of the systems with backwards going TSC values seem to
encounter a bunch of them across some time period, end up
getting rebooted, and then behave well for months after.

> Reported-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Leonardo Bras <leobras@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
>=20
Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
