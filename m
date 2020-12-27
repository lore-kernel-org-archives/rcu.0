Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A979C433E6
	for <rcu@archiver.kernel.org>; Sun, 27 Dec 2020 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3032250F
	for <rcu@archiver.kernel.org>; Sun, 27 Dec 2020 10:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgL0KAi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Dec 2020 05:00:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgL0KAh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Dec 2020 05:00:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76E0520897;
        Sun, 27 Dec 2020 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609063196;
        bh=dMiLn604HhYMXIlBTtFtN+fZtNjX1n/LFmtJGuWfWjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/nhD4qQxL5DHUuYBILLMPqnJJbfzFVNKKvJlI4T87kfOVSGE1UTpjC9DpGloXU+1
         rtq9apgbJUb0xNIaMJzK2TqA3TdRHdGxX3bUpBydN7ugF6y4LlbOjFB96EYMCl7tI/
         RnEB4FiRDtc3NpvVNJrxT/Vb3tHEg2cMt7eXU9fBJrqJixD3iCSbpueduh0Anraza7
         I2vJ21qDQdqKcaQHY2KKiq35JB6lcaEy9267eERRzhABbMPUoBrWVnZqtGHS2mCJgj
         rNLpCql5ydfdHqwPixGvDuyqtmZSeWASGDtbUYcKD8bJYwW1yc2N2BzfphzTJdEZvK
         t29EqMJC3G1RQ==
Date:   Sun, 27 Dec 2020 10:59:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Stephen Boyd <swboyd@chromium.org>, rcu@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH] docs: Fix reST markup when linking to sections
Message-ID: <20201227105949.549cc6ea@coco.lan>
In-Reply-To: <20201226131759.724711-1-nfraprado@protonmail.com>
References: <20201226131759.724711-1-nfraprado@protonmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Sat, 26 Dec 2020 13:18:58 +0000
N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:

> During the process of converting the documentation to reST, some links
> were converted using the following wrong syntax (and sometimes using %20
> instead of spaces):
>=20

The patch itself looks ok, although the description has an issue (IMHO).
Also, some references can be cleaned.

See below.

>    `Display text <#section-name-in-html>`__
>=20
> This syntax can work in html, but isn't the one described in docutils,

Well, docutils define two types of references at:

	https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#referen=
ce-names

The first one are "simple reference names", defined as:

	``Simple reference names are single words consisting of
	  alphanumerics plus isolated (no two adjacent) internal
	  hyphens, underscores, periods, colons and plus signs;
	  no whitespace or other characters are allowed.``

On this type, "-_.,+" characters are allowed. "%" and "#" aren't.

The second one is "phrase-references", defined as:

	``Reference names using punctuation or whose names are phrases (two or mor=
e space-separated words) are called "phrase-references".``

Here, the spec doesn't specify the charset associated with "punctuation".

As this kind of reference is auto-generated from the chapter titles,
I would expect it to allow all ASCII punctuation characters
(e. g. all non-alphanumeric symbols between 0x20-0x7f).

So, a reference like those:
	#Summary
	#Forcing%20Quiescent%20States

Violates the spec, as it would be a simple reference with invalid
chars, but:

	#Forcing Quiescent States

Should be valid, according with the spec (still, while doing such
cleanup, I would remove "#").

I would add something like the above at the patch description.

> and it also doesn't work on pdf. The following syntax should be used
> instead:
>=20
>    `Display text <Section Name_>`__
>=20
> The usual toolchain doesn't mind this unusual syntax, but it causes
> errors when trying to build using the not-yet-merged rst2pdf:
>=20
>    ValueError: format not resolved, probably missing URL scheme or undefi=
ned destination target for 'Forcing%20Quiescent%20States'
>=20
> Fixes: ccc9971e2147 ("docs: rcu: convert some articles from html to ReST")
> Fixes: c8cce10a62aa ("docs: Fix the reference labels in Locking.rst")
> Fixes: e548cdeffcd8 ("docs-rst: convert kernel-locking to ReST")
> Fixes: 7ddedebb03b7 ("ALSA: doc: ReSTize writing-an-alsa-driver document")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>

...

> @@ -596,7 +596,7 @@ maintain ordering. For example, if the callback funct=
ion wakes up a task
>  that runs on some other CPU, proper ordering must in place in both the
>  callback function and the task being awakened. To see why this is
>  important, consider the top half of the `grace-period
> -cleanup <#Grace-Period%20Cleanup>`__ diagram. The callback might be
> +cleanup <Grace-Period Cleanup_>`__ diagram. The callback might be
>  running on a CPU corresponding to the leftmost leaf ``rcu_node``
>  structure, and awaken a task that is to run on a CPU corresponding to
>  the rightmost leaf ``rcu_node`` structure, and the grace-period kernel
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Doc=
umentation/RCU/Design/Requirements/Requirements.rst
> index 1ae79a10a8de..d4125caf394e 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -45,7 +45,7 @@ requirements:
>  #. `Other RCU Flavors`_
>  #. `Possible Future Changes`_
> =20
> -This is followed by a `summary <#Summary>`__, however, the answers to
> +This is followed by a `summary <Summary_>`__, however, the answers to

Hmm... why are you ending "Summary" with a "_"? This should be
equivalent to:

	`summary <summary>`__

In this specific case, however, you could use, instead[1]:

	summary_

as there's no need to use an indirect hyperlink target here.

(the same applies to a few other similar cases on your patch)

[1] https://docutils.sourceforge.io/docs/user/rst/quickref.html#hyperlink-t=
argets

Thanks,
Mauro
