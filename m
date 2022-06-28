Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67465C433EF
	for <rcu@archiver.kernel.org>; Tue, 28 Jun 2022 19:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiF1Tfx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiF1TfV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Jun 2022 15:35:21 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938A3BBFF
        for <rcu@vger.kernel.org>; Tue, 28 Jun 2022 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1656444511; bh=lp6JELsahhZcDxMKcb8gtHLevhfULw04cbHTcBHgid0=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=jjDFzI/yTyGPTE04F5h3wA5bSgKOvp64wtETAjXTs+4HqJ2FLNbr5TUf70XYIsJYoYxJc6JpCo2lfpkyZt39JDg7xZv2zk8F2M+lCty2if+BCt8naUF15x+Yx10scAZ0xXqnGZvjdnXav2bDKNTs7zM0i2hGypN52AZh0Uy0Qlq7WAHIJ0iTDjD1xQ6pW8m6TGvOA2Th7RJeZX5i7qU24jhXG8WUVC0wcjvPfXeRPPuMIBlDZNetbd8959qNtVAGzgDgwuivC5cnTXc18Kw482wloSoNa3WbM/m75NcTCoUtWuz8vTWgc0iYq8hki1X94VSM851nJnnUqwwh7r+6ug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656444511; bh=0UZukaZ+ibNkIFwKKSDOXttoIsXq4gsEK9nnOmqJcdB=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=h8Ez4OgVk5inmzZ5NFmmuTb/QYRhrfo8lfXyLRPTHteLSTPPkYAq89FUN7H4wNoog6fsQwazR10YfOWm7rIFHNsNIKSXrpuL5LI4RgaQqAElgNOTkyr+4CA2yBPQCmJ7FmLHWmj3QEgGIKQV8euF1ELR6MkRISA/t2YCfnIZ89vzdi4PpFu4v335Cif1bXcLdeBJtPXnUPGht7+f2A3eOD+DW34P7rUuR3i7msEruZjIhjKZSKA4vlxzFONfbmbYus2GdybSVa2svtGpl92ya4rZtUdTRsrDFtJjbGk8Vbr6chjXIWWAjNhOiZD770o4kaG0vKumCs0afkKpyPMHlQ==
X-YMail-OSG: zW4xm4kVM1mKC80wsYqU0Hr_NbggFiHuTmO.JnZU6z7OftV5itErH2QpzQMtg1G
 _EVW.99By_8Z7kJBwpO4jud.jhhWd75BFhilHxr1CIlcZiSxZUiRKaUIuiC8Ed.7QCAlXTxxYB6q
 2kzJAMLZH512xS11CkjpSrySfrCfzuWocsYMlNN.9xPLWQ7GwSYCxVkY1Fjwx0MroSpMX7Blj0_p
 hDhhiYYnCKcM62IOXgWbsNuvR1huzBhVUQJGreMnJ592T0NmzFiJmsewsxKgq0QtCebg6IepT.jx
 l_7lyUMYBSPL.o7FNj9Rr4s5jURRigFMSb9IsylwkrunxB0RMJzXuhohv3T7MJMYrm7P_PmO4xoW
 2ASe6x_8rve4.vFexl3nzmwRcyASJa1jiSY_vMpJgTaxGG5l6T4363Gmg3FfYf_0I.lSFpeLI7X4
 KpHV1GS5UDlQfz94GS8lmBL1Hha4w6B8Y3uFFaF_IN51r1Und6SwCg6wkWqHRJjZVx1mQynDmFa6
 C2fj8y4NTUDP1i5fhQGqhTFxDmsMYzNciiEaVGHq_fF6TB.mp9HGuBSAugnCjJ6HnRtxHd3z5WSo
 EXxEHRsqrOKabFy7vQvw1wLuvqSmKZSKAYCxV4lEIwgYoP7vHlvBKv0e4hlTWxJ5CL5WnBIDxf4W
 ViOVjY74j3mQ1NNTRLLcCumtaecx2zvdgPfQeNFhZFP0c_2Kak9_lMUkfuNXesjCoGIKY025rk.o
 DAj5vfcw8TCTCNptpWdw960fepFNlCti8kyVRywXDnl.3udzWJMjVlz1Y9RaQORnIDN1LUtNjP1R
 H2oQtWqVk98Xq3TnvRaNEBuAAKb3HW8HoEl.ESaQoQmblbgmbIv5QV1T9eHO__kg3rpZXyv1gJmz
 gbOezi0P4WN0Y_ahA8ltWZuLRXggSsjC3pyxDPR3x6OV4nO2Ruj_jacC6Ja9TOmhD59KPbP.6DVW
 jqG8GPIXFOfWoUV75Ab6X5hoVvrKl1DPL4RPI5gckWfOAZ7VV7lyDLmsCS7cG503x4DtRAY8G10D
 7Jy173FDRBLBWSDj0X855_7SqvukmYEqLQD9eQpBCNEuQWV7zHo7UPckwGFAfRdfQ6mzt1btyE9_
 GLS7tm2w.n6HpZydN.Ign7aJROAJeWuhYEKwlFj78YzL.c6qNLy7rjfUF.t93RNRs72ZrVsFADp1
 KsfKzKeEmloP1X6zi.0ynJpqqMXkpNwPuXWtaQlV0wUL57c2C_PoW.WqJHT.3H7cLn.XRIMJZLXH
 MR2eZXcnpRahgpiRoMRIxaiRj0.qhgpsZhaoa3Mto1inFSxA640derzNRqN0_FR5zTIUQezXMv1I
 GONJOCaj14_GLSOfrnGttbNnjFz5nnqwVl8ipMKzaSiOWR0nWh2C.6uqNB5KgOdMYdw.GAhho7RW
 yHxeKRGU_hI4G1Xv6XOOmIWoLYQsMi.lUvsaAqtFBf19Pzb0ZnVRSREg.R7pNlYP9G35gTKgnWcV
 .GL5pyzpjh9fF3bP91tJdH8k3yYdHuHZWOA2BDZv7esvO1po5wgMF4lHP2UotQcFLdeHLvQ7kn7M
 qJUP5R7rDREZEjWNVYYrYZfUz4Fi9iLEdYI0gYvqSNsf1r7E8FaMNdngmNcu.cF7Z5wNz_XkY9dN
 s5KekZuI_syol5t2XpPa3Gt_bNxxfsED09.1A1_BxXPlgvqgSkLI5Cj7ZBx4KPU9Ruiu_urP8qRX
 9V9_FzbOgScgdZ3IRJNNc3cJ.pB5cPD6ZqoRtr9eSzcit1sXgROzgEsaoJ4xCzf6ys9NWfkpPnSY
 DybPi_jEWc8XdABn.ROXfwXGX8VVnoq13czgBMrDdlU0KgkKQN81zHKJJn25liLG87WpJXMBoygC
 lb7bwKuD1OcU9FmVbpzcyAB1wO6LyhcidGg1xlEuT1uE8rJZ4IfsA7t9ptKGfdedqK.QcHZBRAdq
 hK3WrfN7vfqkUCMdN8QnCVzwLPy1JdljXrn8Yo_D2ijMqaxpd4T4FbcF6hBh1dGs0z0M8Nl8Up1M
 tIwBUdxALAV2PU1dizE0i2cyO32LbzxIcn2ehbVhaWnRkHOSgQK8kYGjY4QUByPON3Ih1T57xFry
 BEzSnXnHBCuLCUDOlivQcynkvXgArC5T.SHH2rhbzI_0tv1pVs_4fxg2XL98Y7MWJPhhaAX8rOx4
 SkM.1v6QVCDiF_Wchv4ynYtDVFspvJ.rVpw48eZNLTnwMlfFRH0ypjbccMCO9G8WszG0NISaaQDn
 8INTZxamallVo0nWjF98_xc_fCJBjKD3EyDbqhJcbZP8BD3bI
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Tue, 28 Jun 2022 19:28:31 +0000
Received: by hermes--production-ne1-7864dcfd54-clfh9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0ba9c517f807bbba5b63c956b00d8dd2;
          Tue, 28 Jun 2022 19:28:30 +0000 (UTC)
Date:   Tue, 28 Jun 2022 15:28:26 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
To:     paulmck@kernel.org
Cc:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        Arve =?iso-8859-1?b?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        christian.koenig@amd.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>,
        rcu@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, Theodore Ts'o <tytso@mit.edu>,
        uladzislau.rezki@sony.com, urezki@gmail.com,
        wireguard@lists.zx2c4.com, Xinhui.Pan@amd.com
References: <1656357116.rhe0mufk6a.none.ref@localhost>
        <1656357116.rhe0mufk6a.none@localhost>
        <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
        <1656379893.q9yb069erk.none@localhost>
        <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
        <1656421946.ic03168yc3.none@localhost>
        <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Message-Id: <1656443915.mdjoauhqe0.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20381 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Excerpts from Paul E. McKenney's message of June 28, 2022 2:54 pm:
> All you need to do to get the previous behavior is to add something like
> this to your defconfig file:
>=20
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D21000
>=20
> Any reason why this will not work for you?

As far as I know, I do not require any particular RCU debugging features=20
intended for developers; as an individual user and distro maintainer, I=20
would like to select the option corresponding to "emit errors for=20
unexpected conditions which should be reported upstream", not "emit=20
debugging information for development purposes".

Therefore, I think 0 is a suitable setting for me and most ordinary=20
(not tightly controlled) distributions. My concern is that other users=20
and distro maintainers will also have confusion about what value to set=20
and whether the warnings are important, since the help text does not say=20
anything about Android, and "make oldconfig" does not indicate that the=20
default value is different for Android.

My suggestion is that the default be set to 0, and if a non-zero value=20
is appropriate for Android, that should be communicated to the Android=20
developers, not made conditional on CONFIG_ANDROID.

Thanks,
Alex.
