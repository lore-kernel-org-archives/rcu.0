Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0869156237;
	Sat, 16 Aug 2025 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755322693; cv=none; b=gs5dMvtoB1lenrJ71B8tdlM8sMAqywwzKGoQzqwX6FtdL1n6p+ZbxM3frrAXgm5qFIPsxNoDPlkNat6xgrBV8wE08uuPklvWQtxuVGktEw8HUKY0s3pwXWcDXBYBNv1hY2QcplSt4HZ6YqKg00G2QwlY+YZQ3LoKJCOyBdBfXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755322693; c=relaxed/simple;
	bh=tVuKm4RThZoQPlprqmu3ubqUYc/o4CVsIXpEz0C7TD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsrx1MMFIYXLYXVtXMTju7kaeLnJf6Verry26jLbNd2/pf5P0gqxVXNHYYfn8kuoY9FeGf+Whz/lCiLWmJXpHDkNzBtRwQ2rnBXiFOQGuDYDell8+ESGsOTpbkYvDZFCGrvAmdFpdsH8WeRYuLI3PWlTK//wzwW/oaevGzFSBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PESN2K97; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PESN2K97"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f43981so17205375ad.0;
        Fri, 15 Aug 2025 22:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755322691; x=1755927491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txsJxdJLKlLxnXtUbPqcQX6zvyfOTXsnwV+hroXlRvE=;
        b=PESN2K97CZseI+dYzfKvjmUGvYyRyBawOFFm8fCmjwA13BUBNlHnm3PXKLIYrQPfCx
         lcbgPIMSP2OwoFAetUUdbymdgrCubdpoBplEUpb0+mxsfCRHI+AvEbzl3TzYPEnj/XCm
         WlSRpAo65tWOU1tttOb+D0qgp/HVvXPIsLH8f8nbpGVVYgxmyK8ueQLQmWmd+AIT/50K
         HDg8PbAiHB/IoNPrgw1YmM+4kV9GIsHFf9uL/qxRdyeOYcyMenW3fWV3nfPa+/CaV69w
         KLrvJZg3caY8QlNkw2ycWPxUgVbA7lq38va6BPnSGKAhbTqEAJUWc1DdpWtJMJSA6gHN
         uyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755322691; x=1755927491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txsJxdJLKlLxnXtUbPqcQX6zvyfOTXsnwV+hroXlRvE=;
        b=Nd8xOupHEk6IQnnlvEw2VXNWqpvKPn+YfcVT6iVYEs6s9H7MT98WCiB5IH8qVO+E8Z
         ZzH9xrJ57nnhzB4+tTVngPLI/iJDJ/0Iy22kQ9LWdcLCKGV5lh1ERVdgiz9Db83S0l73
         RcCzIKQ75jLEQcQOfbdgn2bsDc/L4kqVUmzA8UIsvAXErE0vLmdpB6ZMWdmZXIvTjq7B
         DXzoyV6KXYyOyg0+XM4Pz4x9MLVlrvSeHjoDbSz9IE27aUdwlcGRPEHESwfu3D77dCkf
         UtgA90By+7OezRsWtrJ71noAaLfMIBLQcIlD7PcxHbjX+58YIWXpO7cTORd4h/bXKp8d
         fZEw==
X-Forwarded-Encrypted: i=1; AJvYcCV6MMtEue4obuhOblx59GaaWyIbhrR0ZIlNeWM6zsMJZui465YKjkT1VIMN3qP1qs15YBZTT7QF+IRZUfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/a1nsf0ekeoT52Sn498hijxCF67k7Pugm+Ngsf/sZFAPYVA6U
	lZb0jiYGlS+77bIbgF0kcEk4H5xatuhsemZoaL/65JY+HTG5Eik/2A9v
X-Gm-Gg: ASbGncuWyxgipExbSkpCb5c/mOez5Bjgxcc8cS4YYKZJhIa5nJnV3QA+R8MJYBncM8h
	o2CV6PuBxYsmH2q2TfoK9CDpogtL5XNzzHbsmALHQ9MWMCOmtxVhmZGxZIHU+cz2mIco8ZCdXgL
	j6Y7sPDaDJ2j06s2f5U68tsbdtGMYacZVFWbp7+zg9jhjNdLYCFRO9wyfKBzfgCtCDlsMb9Yl+0
	ZF4+oooIjMQ/mWh4gPjEquf6s7KWMXl1CmbnEAKiwK/FZ6K+C20saqtu62cDws+MQlFpmxJg0ox
	ZjaAcgh/kCGzSOtiJufOIrYP3tZK/ng2YA/eLB+FULnwUrBNmrjPx3TVo7XvTodJKNHHcvXYsxs
	afpVu0gbeiUCxN97UgDkikRmStCx6iGNk
X-Google-Smtp-Source: AGHT+IENoR3ifLxQCw1zNkdGAsO9uic8/hAXmf6TO+i6IM+xvi9L6a6LzSsO49oQHInyKcPP+Kg2jg==
X-Received: by 2002:a17:902:f612:b0:242:9bc5:319e with SMTP id d9443c01a7336-24478feb6e1mr21577515ad.54.1755322690729;
        Fri, 15 Aug 2025 22:38:10 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53eec7sm27374205ad.118.2025.08.15.22.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 22:38:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C6F7B45187BE; Sat, 16 Aug 2025 12:38:05 +0700 (WIB)
Date: Sat, 16 Aug 2025 12:38:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/3] doc: Update whatisRCU.rst for recent RCU API
 additions
Message-ID: <aKAZPTg-bUcz3ZGY@archie.me>
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
 <20250816000007.2622326-1-paulmck@kernel.org>
 <aKAA3OHvISThlUX-@archie.me>
 <189f6091-016f-4a96-a1f1-321231aeddaf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fRUGg2D+ItjIc3ez"
Content-Disposition: inline
In-Reply-To: <189f6091-016f-4a96-a1f1-321231aeddaf@paulmck-laptop>


--fRUGg2D+ItjIc3ez
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 09:54:57PM -0700, Paul E. McKenney wrote:
> On Sat, Aug 16, 2025 at 10:54:04AM +0700, Bagas Sanjaya wrote:
> > On Fri, Aug 15, 2025 at 05:00:05PM -0700, Paul E. McKenney wrote:
> > > +RCU: Initialization/cleanup/ordering::
> > > +
> > > +	RCU_INIT_POINTER
> > > +	RCU_INITIALIZER
> > > +	RCU_POINTER_INITIALIZER
> > > +	init_rcu_head
> > > +	destroy_rcu_head
> > > +	init_rcu_head_on_stack
> > > +	destroy_rcu_head_on_stack
> > > +	SLAB_TYPESAFE_BY_RCU
> > > +
> > > +
> > > +RCU: Quiescents states and control::
> > > +
> > > +	cond_resched_tasks_rcu_qs
> > > +	rcu_all_qs
> > > +	rcu_softirq_qs_periodic
> > > +	rcu_end_inkernel_boot
> > > +	rcu_expedite_gp
> > > +	rcu_gp_is_expedited
> > > +	rcu_unexpedite_gp
> > > +	rcu_cpu_stall_reset
> > > +	rcu_head_after_call_rcu
> > > +	rcu_is_watching
> > > +
> > > +
> > > +RCU-sync primitive:
> > > +
> > > +	rcu_sync_is_idle
> > > +	rcu_sync_init
> > > +	rcu_sync_enter
> > > +	rcu_sync_exit
> > > +	rcu_sync_dtor
> >=20
> > Looks like inconsistent (normal paragraph instead of literal code block=
 like
> > the rest).
>=20
> As in the "RCU-sync primitive:" needs another colon (":") at the end of
> that line?  If so, agreed, will fix on next rebase, and thank you!
>=20

Yup, that's what I mean.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--fRUGg2D+ItjIc3ez
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaKAZOQAKCRD2uYlJVVFO
o28xAQCv3ZdwzUTnkUnE2e3t3pAFt6rIXVPbCwDpVtE+3nnl/gEA/Th5PMG4I5ZD
hhY8topuPyY9IUxkJivRPgOk51rvLgg=
=jxTA
-----END PGP SIGNATURE-----

--fRUGg2D+ItjIc3ez--
