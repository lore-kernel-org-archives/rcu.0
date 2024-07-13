Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AA1757D;
	Sat, 13 Jul 2024 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720891016; cv=none; b=q0+bO1zDMVbVBr4x/KfIsb4A273lCTiqxM1KOR6p/2uW0JhH2/ENz33UDJ40A7WXDzPBAOo5eKMNhpvtWmYZWT/PNUrBaIebdqJgGHSkoLlo1qUj+ph74vgkgJtD+Y4Nxe6NdvmMog20J/yI8x88cTq2NQE9OIn+iYnlnRW9664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720891016; c=relaxed/simple;
	bh=yvecYwcOCWC8daVyn2D3EoAxG9h0nFQH4t1J3vkDOyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQ699xMITp5Qu9HHJji+l9K1BAEfYgOdAfkE+tPzfFWdRzYoLn2kQy3xGMlm2VtKbqReF7CGitLu/Ne5qvtzCq3tpGY7ZXlWQ+cIXB8XSi8pWYuoiqqt0kdKK9o7YRSb7L8wI+urUcRZY3Lv+Hq87yM+K8Onh7Xfk/gNSfirXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sSgMZ-000000000DQ-2AT0;
	Sat, 13 Jul 2024 13:16:47 -0400
Message-ID: <ee33a2c3e32d98b5fc04983745c47f918f9ea2d2.camel@surriel.com>
Subject: Re: [PATCH  2/3] locking/csd_lock: Provide an indication of ongoing
 CSD-lock stall
From: Rik van Riel <riel@surriel.com>
To: neeraj.upadhyay@kernel.org, linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
 mingo@kernel.org, peterz@infradead.org, paulmck@kernel.org,
 leobras@redhat.com,  imran.f.khan@oracle.com
Date: Sat, 13 Jul 2024 13:16:47 -0400
In-Reply-To: <20240713165846.216174-2-neeraj.upadhyay@kernel.org>
References: <20240713165642.GA215331@neeraj.linux>
	 <20240713165846.216174-2-neeraj.upadhyay@kernel.org>
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
>=20
> @@ -228,6 +241,7 @@ static bool
> csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> =C2=A0		cpu =3D csd_lock_wait_getcpu(csd);
> =C2=A0		pr_alert("csd: CSD lock (#%d) got unstuck on
> CPU#%02d, CPU#%02d released the lock.\n",
> =C2=A0			 *bug_id, raw_smp_processor_id(), cpu);
> +		atomic_dec(&n_csd_lock_stuck);
> =C2=A0		return true;
> =C2=A0	}
> =C2=A0

So we decrement it when it gets unstuck. Good.

> @@ -251,6 +265,8 @@ static bool
> csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> =C2=A0	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d,
> waiting %lld ns for CPU#%02d %pS(%ps).\n",
> =C2=A0		 firsttime ? "Detected" : "Continued", *bug_id,
> raw_smp_processor_id(), (s64)ts_delta,
> =C2=A0		 cpu, csd->func, csd->info);
> +	if (firsttime)
> +		atomic_dec(&n_csd_lock_stuck);
>=20

However, I don't see any place where it is incremented when things
get stuck, and this line decrements it when a CPU gets stuck for
the first time?

Should this be an atomic_inc?

--=20
All Rights Reversed.
