Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57761F16B;
	Mon, 17 Feb 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739758994; cv=none; b=TctZvs7IffGV4hMQGrqBFu+jOs4IQKOoWDKyXhAkAGQDhfz6MAhFK5KOHXe3UERMlRviju17I2QbwJQZHe6+pSfSTYPCSj2i0/Lc7AFqJ07Ts3aacl8tZ4qz8ikeYtF+C6bVx0FATPUuAc1tVag7CPB2gYtnvb1Kcq5gkBDaFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739758994; c=relaxed/simple;
	bh=nJKa6bALEhYgO74p6lWul8puVtnEmAKvhZMCNo2iu2o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iXrgcP/M3LamPCdEnDcIXqcYw1NilOY5g0zL8eBBfqv5XgzfsjLLhHJ7xReqvbu/WManxyma3baZGpbRtGLIXqhVthKAWA05gpgT3O9mnCTFDSO4BZx0PTlmZHvmJD12uWJEs2iSovCK0s84PkOsn1NthLrPLHM5Z8GMod9jn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjDLTNZu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjDLTNZu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a12eb6c0so9289585a.0;
        Sun, 16 Feb 2025 18:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739758992; x=1740363792; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K6UIgLK2BUUt0MWARkWgKarU0VGbzAyBiqh/DYSwyk=;
        b=fjDLTNZuKi2ZcqSJiLn0nC5jV9U6v8IDOhz/AA7Gl7EhFeIwfO5Kf9oGgoxsDBHaXR
         YULr6+6jrAfDNKspm0dJvCyqDNiFQ0zseEdR6e2MyqoXhaGloiJjxZ22Gz3wOyC3iFEj
         bHTlxT1xrPi60uxD0w4ywjxevqRWN/9Fq0XeXbFEPptus0utjA1aN3yAqf6AIkSoY+tK
         kz/SLK4u7iYC0roMmkw9XV7uUzj6WOoc9RCE1kPkTrQyV9G2XrYcxBaofnFitLanxVB5
         pcD3aorA0dSoqQhYcMPEAqLOIOWDioFRJ975T6g/F0ZMBIJmbyiS1uRqz5O2QYnDf/dV
         uBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739758992; x=1740363792;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K6UIgLK2BUUt0MWARkWgKarU0VGbzAyBiqh/DYSwyk=;
        b=C6D7Mahy8Q3W2yArWGNrN+qCrtVRF0oOJayciPNoOkPSKbmK4nS8BAYr4kjZKAT4fR
         HQymmml+yHaiS/cLQitGRfMUTsHoZx9N9OuhC7hNn6ihMxVLr0Izcei6TE4EUsO2jVfS
         D9nyfZBmRHUuz2n6xJOgzdx87xvctOMmTvyOTtVTe0QUO7v8qhF4SVJwjG1zpqmSUJUS
         y5nUcV9agf4Ikpkth9wO76qfDTaTN1P/0HHLHhwxrCPZT/MX5yD+FFPgzCXafiA2QHAJ
         k+6t7ZSwTWbhJuEIqDYrAbIlH7Bf48toGC6dJ+lKvTcudWmOFmrg/h/rI+6U316dbSNg
         iA4A==
X-Forwarded-Encrypted: i=1; AJvYcCVwGQL+Wg5e3DqW9Uc5w/VEJWJ17T/iBCwYIcKELNyz5yFlC933cnhXdyO+VaJBhFKoZvA1@vger.kernel.org, AJvYcCXorKkjnaeAU5GSsKrrud0R+Yu73HeiU4zg5maQA1KEbGhO9Ks0G91pyTrDytPEvn0/Isa2iMAoPfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVnMTAysrzBw57weKJm7j8yGvDz5Hk1akafEh/v6RVE6KZgIWX
	8aYia/QuGx4EkFCUvo3d6Mm+upJ7y64PTXaTZaPGE6bZihenNBM5
X-Gm-Gg: ASbGncsI3yescD9XIrng2AtFVfHxvRGgoHCM3ASsCod8U9nWH3R8k0wWSXiG0kiQ/1c
	k3WLZLvPc10vUZoEjxAj8Jkl+FocZdtQl2JP6q+HsWeSN6EhFDRFI9BeWYgm199y0/SA8e47xFi
	Mc5zJEjePr/7N+vjL/pipSvn94XQJUAFMr2HWVATqMZ+imn+GFhylglSXY54fGzE966T4elzawh
	vQM0f1pTLj2VuKOgunmkrChhmzDrpp7+DrfzxFDK1RlyqdUoUQQTIG01/LHGpJiIJKAjDTRYK8=
X-Google-Smtp-Source: AGHT+IEqn63zCbq9V5q9AfcMKEKiNo7blyxShQtxPGVnCIoluf+PsU9BykLNNordLTRUekbGAOO1GQ==
X-Received: by 2002:a05:6214:1d09:b0:6e4:3e5e:56d5 with SMTP id 6a1803df08f44-6e66ccb1064mr134910126d6.5.1739758991678;
        Sun, 16 Feb 2025 18:23:11 -0800 (PST)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c29e94edsm42038071cf.8.2025.02.16.18.23.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2025 18:23:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <Z7Ka8Z5RS_OwyL_G@Mac.home>
Date: Mon, 17 Feb 2025 10:22:53 +0800
Cc: Wei Yang <richard.weiyang@gmail.com>,
 paulmck@kernel.org,
 frederic@kernel.org,
 neeraj.upadhyay@kernel.org,
 rcu@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
 <Z7Ka8Z5RS_OwyL_G@Mac.home>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

On Feb 17, 2025, at 10:12, Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> Hi Wei,
>=20
> The change loosk good to me, thanks!
>=20
> I queued the patch for futher reviews and tests with some changes in =
the
> commit log (for title formating and a bit more explanation), please =
see
> below.
>=20
> Regards,
> Boqun
>=20
> On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
>> The example code for "Eliminating Stale Data" looks not correct:
>>=20
>>  * rcu_read_unlock() should put after kstrdup()
>>  * spin_unlock() should be called before return
>>=20
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> [...]
>=20
>=20
> ------------------>8
> Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets
>=20
> The example code for "Eliminating Stale Data" looks not correct:
>=20
> * rcu_read_unlock() should put after kstrdup(), because otherwise
> entry may get freed while kstrdup() is being called.
>=20
> * spin_unlock() should be called before return, otherwise the
> function would return with the lock of the entry held.
>=20
> Hence fix these.
>=20
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Link: =
https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com=

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> Documentation/RCU/listRCU.rst | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/RCU/listRCU.rst =
b/Documentation/RCU/listRCU.rst
> index ed5c9d8c9afe..8df50fcd69fd 100644
> --- a/Documentation/RCU/listRCU.rst
> +++ b/Documentation/RCU/listRCU.rst
> @@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` =
flag and a ``lock`` spinlock to
> rcu_read_unlock();
> return AUDIT_BUILD_CONTEXT;
> }
> - rcu_read_unlock();
> if (state =3D=3D AUDIT_STATE_RECORD)
> *key =3D kstrdup(e->rule.filterkey, GFP_ATOMIC);
> + spin_unlock(&e->lock);

According to the above quick quiz, we should return with the lock held.

> + rcu_read_unlock();
> return state;
> }
> }
> --=20
>=20

