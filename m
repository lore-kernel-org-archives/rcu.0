Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656A13DDC9
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933740; cv=none; b=u6EcgHWyhImU5v4jIOjacv+UpBKvrIJYlJGFjZTwRrCxGycLTLTK5QcZ/orbLs1Za5tJ1pP1DZYZGAxwuH4N8csXjEozBlB11uyZWSDEpZS36UjZ4D+xsreGzPSEEe0EvFa1ga+7pTFdqe1Ot9xGgkCy58Wd0bs2wGr7Yc1MthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933740; c=relaxed/simple;
	bh=EdcGUFN9AFccCismNanUEwL6FaHcN6tmwft2atRh2AM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYoQZ1A58AdvKQrlLYw7TYkVqdWnY/uy4lsVSlMk9BYXHdqi5rbeXq/meOL8Rb+Vg8nISF62OcByBz2XkcSjciFnSLMpC49lPpc9mpU6QM0c/kXXpUww86oAgX8yjx0CL3TtZ38NsVPSqRrZXDfWL4Gbtr+DygicR5Ac7/Oqdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OvLFAPCI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OvLFAPCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1716933735;
	bh=5pguTA0sqJkiJzfGASVqyrEyfaeQoMUbbhfpb7WGRZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvLFAPCI1H9T3NC5BAbJSUbkQ08bHLIQ3d1bgcWXg94l8RvVjLcdzPZPHThfcdl2K
	 Tqk3rcBR4AC452DVRG74AQYpJW3M9urui7KVDL1B7oiFlKkls97X0ZxfHYuIyszYmK
	 rh3x47HwZwMGbmw2h5aZy58l+ZP1YLFJ8MHGsiPHFqb8YcUe2LkCmfHuFb+LgfZwLP
	 62WjsyMWlZ6UUdp61VhQZLqBuLUg0NK6jBb5M+GP0i2SQZECrmUGgA+ZppzzVEb0ll
	 RbzIkvrQXt5Yk5f4UlRkgLKnMmtACKfwxKBLoUp8wEJcwG+4qXZ4nqXD5yCa23FP1E
	 RixPlzX066tsg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpmhQ6C9Vz4wqM;
	Wed, 29 May 2024 08:02:14 +1000 (AEST)
Date: Wed, 29 May 2024 08:02:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 urezki@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: Updated -next branch and repo for RCU commits
Message-ID: <20240529080212.21a8ab42@canb.auug.org.au>
In-Reply-To: <732c43ae-6d7a-4a98-995e-e96086a94678@paulmck-laptop>
References: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
	<732c43ae-6d7a-4a98-995e-e96086a94678@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R3i7VQHsHi2QrQvP+jA=PSh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/R3i7VQHsHi2QrQvP+jA=PSh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, 28 May 2024 11:54:44 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> From here on, could you please pull from branch "next" in our shiny new
> shared RCU tree?
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux

Do you want this to replace your current tree, or in addition?

> Please let me know of any questions or concerns.  Or, for that matter, if
> there is some automated way to do this that I have long since forgotten.
>=20
> I will still have non-RCU commits from my own tree for -next, and I must
> confess that the name "rcu/next" seems entirely inappropriate (to say
> nothing of confusing) for that purpose.  Would you be OK changing to a
> branch named "non-rcu/next" or something similar?

I don't care what the branch is called as long as it is a stable name.

I have done the following for now: added the new rcu tree as above and
renamed the old rcu tree to be the paulmck tree (still fetching the
rcu/next branch).  Let me know what you want the final set up to look
like.  Also, do you have more contacts (preferable full email
addresses) for the new rcu tree (currently I just have you)?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/R3i7VQHsHi2QrQvP+jA=PSh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZWVGQACgkQAVBC80lX
0Gz2dwf/ThHHR+yDYYNAx+SrJxdb7/eySowsoJ+N+p0e3k9gNhjW3Mbcm+XviBek
o71vIhwmwqNvSYW0WiAbgntRd7PNc6DthP2ilxGnSIw3le35WgvAusmWsmoxQ+np
wRkcVsSmmDK039NIkNiAinXAJFkk2iAmu0oBaeJuL76uUj6OyeotacH1slhpIEVd
4j4WaXXpeU0BLaeA4gJ04mpbxzx7yV57Bpuk61hd7ePbQ8MfcL55jL+sZtbgHaaW
0XUE03z9VkxhRyPljIU5JiMiUaOerHJAFSiAlJ89Jv1SZa3wPc6xDVajEbdnCPE0
ZddohGPyfSWpJ1OjRlyFFHJum6SB1A==
=UfnW
-----END PGP SIGNATURE-----

--Sig_/R3i7VQHsHi2QrQvP+jA=PSh--
