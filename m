Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDCC8EB;
	Sat, 16 Aug 2025 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316450; cv=none; b=thxyhWMn9DiW/rkhx13fffWfVslgYV+caZkrgiyfQYSZaiiCjrHJbyJHFLEbEIEHB8d7hx+VNq3zz3LuVy8kODLMLh6PAIzsvI8xqvVvR8ZAua7/WuL/TperBpPots04AEVW0duJ6mJAVLqMfF8hircO3sLmDK334Iks/qKmAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316450; c=relaxed/simple;
	bh=fxvicm52WISCYfgWHWVWd3u3rkdYmcm8O/xICpLXpJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyAeU509qCvHbEjWLOtk755acrOjdI9um3Od6aXlV0c/HlANTEORxREsjTVJ/Qk0AA8vAONeBmnmJlU4ej93MlggB5KYM0S0pjSDWY+rlGTUq5ksvX3wEqOm+PJ9YlJciNCUK307eJFZGvFUyYMInM4qdm4ngBFraLgwQqeHcdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtU0X/f8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtU0X/f8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so1544682b3a.3;
        Fri, 15 Aug 2025 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755316448; x=1755921248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBXYGJTAqCqDCfB+RH4qZdu2913ppW7rW3q98ghsrtA=;
        b=WtU0X/f8RRHcNAjyCTlJYEBaD4ROWzBHxd1YKaIzhuI3jZmN3RjU7l1rL7D5u1a8hb
         9t5qOUD7yBdm99VuHeRGT3YUflgSAXJX83O75TrjlVsS9hg3f1ueu/HZndXpxH7ek/qo
         snNvw6w3RtIKzNF4apFl1WBOYzyLwyK7TIw1pRMpjgheAuY8rq5idvImEdkyWilz8jyL
         eLVamoeqKcrNCPkD6kojMQDeNKnKpNETJOrN4JMQF4Kaz3DjRHybXjfKRiKG20cFJEMC
         CQwD0I33F+VecqfVhBaUtiQu5S/60TMnauL2qy4iu7yz6nc6ehYN2AAfq8c9PPQN7faf
         T31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755316448; x=1755921248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBXYGJTAqCqDCfB+RH4qZdu2913ppW7rW3q98ghsrtA=;
        b=C34+waqCBCiuNtD1SlvT5z6xequheqD+vFr+S1Z5Elv/BOAYljO+2Vq9eMtDb3L+bt
         ozBRJ1tCdBCBSGBlTOI5ik5C+V0cwsYkrZW67VDKyB8304s/IsNtZsf10dR52Fb1WY6V
         Os/1HLDrjsLmCJXABdtFbTVqItOGK4PWtIg+BtmVod+jcJMHhp4/2OeJgGZcGbpX7aFZ
         orAmsQYS6sOX82wTDzPj5B2IYmTgqstJUBy8kzu/NGL84g3G6hDjbuHvkYhAzHNFPhuG
         JG/MrjtrpPWsoXdl7V00hbAerQxnYdhErlAaXzLR+BlNxfJxfBwdDJteMmTHN2lBVEcF
         3G3A==
X-Forwarded-Encrypted: i=1; AJvYcCVpGyViap0Boo8LJrPapCHHg6pYBzpQ8qOZsUVRkd9rM4RpOqc8NzVu+RxhNEVizn/nB5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVjtPDHZrLBJmsJfMKEtYdy2zU9KcswigkV7e3HdCe3jZK/Se
	G8QHjvHnj001X/FnDOIBrsf8W0bOCKUecgKCKW/wpCF0Bt5NBxCtZpZd
X-Gm-Gg: ASbGncuR/+dDxRfwzlbo334c6bQ1RZO5WZJJPG8uXjj243gGPAUZKRtg1CXG8Pk+XvI
	kEhCOQOGWRf6muNRsePqZUmZhv4Xvvuup9kGQ5Ml/WcylwzyZW3HTuEu33+wf5anhZhLdTHHcEH
	ExNiW6CBhiKlWhshNTM25QgLivdz7n7C8XKmih1nWLggnyiGanT3mV41/gj2SK1qnNuYb1g67B6
	XBli8Ew1FKnHwhWqcgceJHOe3f45Y2xAN514Ngr6ft+7gRgtUpKuzPjlxL0sPsBnx0dTFPEWnq1
	xwXY1PkV0Vty+uSHQ0jEVV9CplitUVv5PmcwGnmpBISHus/WivE0GkQvFnbeygh4G05BYiFeDrO
	ErAoBml1qFh7XX6Lg+hli/w==
X-Google-Smtp-Source: AGHT+IHsHCAks15A9PVkrZkY/zv2SXUkplxDH3JcooQQnxstIPoF1j4eU1U4v24/6bAym4GWBt7W3g==
X-Received: by 2002:a05:6a00:4fca:b0:76b:e1c6:35d6 with SMTP id d2e1a72fcca58-76e5151e0b0mr1832890b3a.0.1755316447869;
        Fri, 15 Aug 2025 20:54:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528bca0sm2270816b3a.34.2025.08.15.20.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 20:54:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6A8424207D08; Sat, 16 Aug 2025 10:54:04 +0700 (WIB)
Date: Sat, 16 Aug 2025 10:54:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH 1/3] doc: Update whatisRCU.rst for recent RCU API
 additions
Message-ID: <aKAA3OHvISThlUX-@archie.me>
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
 <20250816000007.2622326-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVJj7PYbMjjOCHgo"
Content-Disposition: inline
In-Reply-To: <20250816000007.2622326-1-paulmck@kernel.org>


--iVJj7PYbMjjOCHgo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 05:00:05PM -0700, Paul E. McKenney wrote:
> +RCU: Initialization/cleanup/ordering::
> +
> +	RCU_INIT_POINTER
> +	RCU_INITIALIZER
> +	RCU_POINTER_INITIALIZER
> +	init_rcu_head
> +	destroy_rcu_head
> +	init_rcu_head_on_stack
> +	destroy_rcu_head_on_stack
> +	SLAB_TYPESAFE_BY_RCU
> +
> +
> +RCU: Quiescents states and control::
> +
> +	cond_resched_tasks_rcu_qs
> +	rcu_all_qs
> +	rcu_softirq_qs_periodic
> +	rcu_end_inkernel_boot
> +	rcu_expedite_gp
> +	rcu_gp_is_expedited
> +	rcu_unexpedite_gp
> +	rcu_cpu_stall_reset
> +	rcu_head_after_call_rcu
> +	rcu_is_watching
> +
> +
> +RCU-sync primitive:
> +
> +	rcu_sync_is_idle
> +	rcu_sync_init
> +	rcu_sync_enter
> +	rcu_sync_exit
> +	rcu_sync_dtor

Looks like inconsistent (normal paragraph instead of literal code block like
the rest).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--iVJj7PYbMjjOCHgo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaKAA2AAKCRD2uYlJVVFO
oyzvAPwOXv26GjZPJ4r7xJ/FHCS3yUzvoSfU0yTvYr/qI6tmDQD/aYRkvMiGSguN
stVxUatSYoWy/aJ75FdWrUc1o8PQnAo=
=sssj
-----END PGP SIGNATURE-----

--iVJj7PYbMjjOCHgo--
