Return-Path: <SRS0=HuQd=5F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8CBC4332B
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 02:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321B820753
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 02:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YsOglcXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCTCAX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:00:23 -0400
Received: from ozlabs.org ([203.11.71.1]:38701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgCTCAX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 22:00:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48k6Rk3DG3z9sRf;
        Fri, 20 Mar 2020 13:00:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584669621;
        bh=UnT6XT0MYiF55r9HJ3HCBsQ9ZrUxRyyw2v1Npc7EL0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YsOglcXFdBl+mfv+HSaknS4e0l/veMNO/kzbzb7q0ZVexltnv25UgQrVaadL+y0WD
         9xb0MZyKff24EP0xKg7HrX8+fKO5/sUtpTdZmQA1avqXEdDLpmxO/Lsj3YSl7u/0wY
         PT7ISW3ojXOyQLPMy1kRevER+gj7HgFY2qZfCFh15xzKKe/39aYFpsVogYOd7XNqYg
         DlFwzVADIG8IG0ds2hN+k0dju+0A5u+fT9QGn+5V3hqBCdkw1AVIeGKzmlcZH724p9
         XNrutal6nwLRWvbzZqKoi34FiBQYzAZQ/K/j+5TPodQpB+gzJScF+3p4TFXvG0VmwG
         iC7zWLFmiyf0A==
Date:   Fri, 20 Mar 2020 13:00:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Waiman Long <longman@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Hard lockups due to "tick/common: Make tick_periodic() check
 for missing ticks"
Message-ID: <20200320130017.6457a1e8@canb.auug.org.au>
In-Reply-To: <218eed57-27c8-12c0-6f5f-111874798c21@redhat.com>
References: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw>
        <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw>
        <11BEA1A5-2E93-4E01-A05C-A6BA73A74CEB@lca.pw>
        <218eed57-27c8-12c0-6f5f-111874798c21@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/200+A/5+J7anyPW8F._3h2Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

--Sig_/200+A/5+J7anyPW8F._3h2Y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 19 Mar 2020 15:00:35 -0400 Waiman Long <longman@redhat.com> wrote:
>
> On 3/19/20 9:58 AM, Qian Cai wrote:
> > =20
> >> On Mar 6, 2020, at 10:33 PM, Qian Cai <cai@lca.pw> wrote:
> >>
> >>
> >> =20
> >>> On Mar 5, 2020, at 11:06 PM, Qian Cai <cai@lca.pw> wrote:
> >>> =20
> >> Using this config,
> >> =20
> >>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config =
=20
> >> Reverted the linux-next commit d441dceb5dce (=E2=80=9Ctick/common: Mak=
e tick_periodic() check for missing ticks=E2=80=9D)
> >> fixed the lockup that could easily happen during boot. =20
> >
> > Thomas or Stephen, can you back out this patch from linux-next while Wa=
iman is getting to the bottom of it?
> > I can still reproduce it as today. =20
>=20
> I am fine for reverting the patch for now. I am still having some
> trouble reproducing it and I have other tasks to work on right now. I
> will get to the bottom of it and resubmit a new patch later on.

I have reverted that commit from linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/200+A/5+J7anyPW8F._3h2Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl50I7EACgkQAVBC80lX
0Gwcpgf9GrNX0tgR+8h70/3dJK9k3j3brlFdojIdgsIoGvZLrAWhWM8U4l+MUhyz
rzZjPYh5wkODl5WslcB98b6psjQv0i+RnbaQVSiKJVqcALwmveJ0YjAAVO0SrVQ5
Ydn33ybWtrnzgnCHrp4HyrqxyEkd9LvFsZwpcxyRPNitrlTyEM1xlNNEl7TIweU2
Pr+cPbX12MX+iZFid3j2n3Jya9ldTwiUtGjaGv0X+R/jUlMUdJJ9CCAG3jFPgoK4
RdwWpJZDkbR2n9T+L41Aaf4eWiALVG+YnBbXwRNXiWuGL8MgjVHALVxtD/gTYMnc
PXT0kDNSrU63uKm9f6g4WpQnPaX57Q==
=hKZY
-----END PGP SIGNATURE-----

--Sig_/200+A/5+J7anyPW8F._3h2Y--
