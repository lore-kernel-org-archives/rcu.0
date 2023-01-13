Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A4EC6379F
	for <rcu@archiver.kernel.org>; Fri, 13 Jan 2023 20:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAMU6w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjAMU6Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Jan 2023 15:58:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC77989BDD
        for <rcu@vger.kernel.org>; Fri, 13 Jan 2023 12:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6368B6232D
        for <rcu@vger.kernel.org>; Fri, 13 Jan 2023 20:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77B0C433D2;
        Fri, 13 Jan 2023 20:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673643407;
        bh=QY4PGtszzV4T88VVpV89TXZuSwoJ7zVd9hIBQsNKDhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGC+rJEh1X182Z5FkZLc3jO36D8xEcIZVIgyG742uHEFe5/LItlsuwkJkU8LZZ2CD
         R61jtRXW57vVWRShmE5aT7NcOnh8F66xQTFabSpgrvcuorXNIdPTnjpKU/fSQqRjFs
         xbF/E3Y8qH88bVBM1d7yIzQ6b97abEev22Lof8OH9KtmVN2GWCpO7cKAdRmEqTjAM/
         K4yJSFdy1M1Gf3iueYSNva120J5epID7C6TYdjBKBY5y6TBPfv2R14GjXMRFBr58B3
         nhfE2jNjWWvaZ6ztzRZq30SH4q7q8QwnMxJUPGx05u/ID5j9JVLpV1XFwpJLjbkrO4
         RcyGGr0xliQ0A==
Date:   Fri, 13 Jan 2023 20:56:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, quic_neeraju@quicinc.com
Subject: Re: Diagnosing stall in synchronize_srcu() from rcu_tasks_postscan()
Message-ID: <Y8HFi/4kGc7gSAL0@sirena.org.uk>
References: <20230111212736.GA1062057@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FRkblmk1UN+FOtnv"
Content-Disposition: inline
In-Reply-To: <20230111212736.GA1062057@paulmck-ThinkPad-P17-Gen-1>
X-Cookie: I know how to do SPECIAL EFFECTS!!
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--FRkblmk1UN+FOtnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2023 at 01:27:36PM -0800, Paul E. McKenney wrote:
> Hello, Mark,
>=20
> A few days ago you mentioned stalls in RCU tasks.  Neeraj has supplied
> the following diagnostic patch, which will confirm or invalidate my
> assumptions about the cause of the stall.
>=20
> Could you please try it out and let us know the outcome?

As I mentioned the other day I'm having trouble getting anything I build
to show the problem, I'm noticing it only for jobs submitted by KernelCI
to my test lab.  I'm still poking at it a bit, and trying to persuade
the automation to process the branch I have which should be able to
trigger on random commits which would hopefully also let me trigger
things that way, but at the minute anything I build myself appears to
run fine even when I try to use the same toolchain and so on.

--FRkblmk1UN+FOtnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPBxYoACgkQJNaLcl1U
h9As4Af/UQNC7om8pPovl0s6w2rFfJQfOV+PJrRnO5G4zB+xFxnRNoEbYGHBJlVm
iGKq24olRr+mrpswr38kejqf8QuiBsVwQl09cm1Ye6H2Avcl87zdmfP/fJ5ab9ys
LChch8/W1/FVGKnxwq2/TlXUlrN0iotlzvArrE1p/rVfj1Uw5L3DFPJSKPrD02V8
N+0QZlmF7S+qFx3ePvBBwZ4J6ISNgEnoD1fLTHI1XfPaSMJ9zfmYnE8tVyb8n+Vi
ClIxL4brJSsLZ+HKtVP/xCoEnUCPJmb6WJCX+j5SzE8NBHfhOr+FXWlnsXEbGzMg
e33c1H0luRcF8QsoY+2IS6oYhYOSCw==
=6WXt
-----END PGP SIGNATURE-----

--FRkblmk1UN+FOtnv--
