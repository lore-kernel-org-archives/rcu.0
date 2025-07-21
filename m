Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5E469D;
	Mon, 21 Jul 2025 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753072159; cv=none; b=nejppqIphbXE7enYJVPfQcofeSJeEdfCwWXIDaJyrctKk1tSlGwuH3ar28S4bc8oZgobxZA2KTre1NEMXOGGjJaBJYthOMY02iHTqQdrhFjRpdYn6wCPKPyA9yEQUAPHuZAj2yQ7WcfYkYISEjrQp7KFMMFlTV6KHFJ28Gey+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753072159; c=relaxed/simple;
	bh=qhYDC/KKBL7zOyNnQYmLVKRkgEx32x37YXcJEbACin8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/yk5Z64SQ3khf3Oyn3leuSmy2txjN/uVGvQUNxQ46e5r12SshuzuWomgX8RakVR36ceJI4H1md8MPHrEz7N2OuWmPsq6lqZ6zc1HfsgaZLvw0+byv+U87qJ8iKLT+SwmCL5VtV1npvB7N58rqt2mYDCOqpgxUBpSRG8k+f4CcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdT9MA4B; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdT9MA4B"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3a604b43bso652574366b.0;
        Sun, 20 Jul 2025 21:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753072156; x=1753676956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubmicVf2goW+FVKc+LU7OitL1iuFvw5JJnjIYdiaveA=;
        b=RdT9MA4B6jATgejIx6CTWGqKoFDDhZcyY82DHvFohB/IgViG3IvfLp0p67gBtVCkOD
         TapyA4LQKQPDJzOoBAk90+BQdOLdn24it4EAkiwHM5CyFi17Sl/e68LSXlhJ3aa9S+XD
         Tmcb7Vm6s9gftZId+kjphvmLfTp86RuNuP8DVlksQXSx3Vrjvm9yOVVysvrW/MPeIn9U
         sRc4w7MQwKiq8AHIgW0VeMY5CXp6YKPEgW+xS2qxxJtuz2VD4ognoU6mw4NdpkeYURwR
         b8FJM216B+EGx1kFBNuJ6aVy1dWiyyhhMnJMTmFqA4sDH9T+N26IxAK8PIwqfGHNXBQW
         kDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753072156; x=1753676956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubmicVf2goW+FVKc+LU7OitL1iuFvw5JJnjIYdiaveA=;
        b=L6X4g4I5WTGfzJLHcfIoVsIoq1jDp7x9hsBZzye1eJ2kGr9IwxIaON5LpgYSEtUj1q
         gVO0jcOHsvYaOSKE308cKYefJP8CHxleeOr0Hg0CnX2Jp7bn2k/+AbCD/dH+pwwXQw59
         FcOqzOIX0jzcr4DSz+XJQ9HwGQOUKoCsvhWlw8a4XQ8lxZyfJ8OZNgnJ9GOA0xSu6cDI
         1/fvJA50dSwRYvvNHhLF0yw73LDDtPoAxXqebqd03CPPF+CKemq/EXo/2+V/HwF5SYpy
         INYcOEpoUOreCTva9mS/b04gWDXeQonclfFLRED0/CibTMroiwIXIOjM3Wa2TVFeSout
         xttA==
X-Forwarded-Encrypted: i=1; AJvYcCWBH6tU1GgR3Kfw349l2w4TOKaDW5EzPrLyul+c3RXrYYTrEf2nssVMUgOCo2xzmBgSFh3Oic7bwPtaEMg=@vger.kernel.org, AJvYcCXB1V1CTNHCzh9qbcGxneYFoMnP+cL/cUuabzn8qzwN+4HN7/UAicUs59W/uZBfnTi7ODXG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BlO3InyZX271kLZdMZEQ9sLT5F+NITxOJpB57r3w2sHheduT
	l+txuYkhyAryQ9aP6UZJ56hG/Kk3eo/eLuykd4NowBaZVmDSigbyrUh/wG8PsGocmmz3g/a21Bo
	4XVz23fcfvdiESjqvWWFmbPUBtxi/6R8gaT1i
X-Gm-Gg: ASbGnctH1GpaVwNzVi+rMOJp2KdhwpNxbljgDSg+K9Cvzamlk3lRCWvLWXfbfDEc1qV
	eRFKyX9gFjMYMkCsJCx9EiS39JKFMH9AdUhAQ+2s0AEiwjxN+wbWgDXPayjXr6LnwHX2m73xZYl
	UI2sIQwUTJ8AoHPAHLJgMb8p7JRsMuuQIDK9HLGVrbcuerVt6F4Rdgz7k602oK+xOIAV4wPdiCd
	o1V+A==
X-Google-Smtp-Source: AGHT+IGow/pNgwagC3KDIUFhh+2rlHq1wGfCAQieSfDBOYgm7ETzpEMkq9dmNHeWUW1UH3Ny2LPnXa7fZ727tcNgdLw=
X-Received: by 2002:a17:907:fd15:b0:ae3:cf41:b93b with SMTP id
 a640c23a62f3a-ae9ce10b28bmr1686896966b.41.1753072155798; Sun, 20 Jul 2025
 21:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715200156.2852484-1-joelagnelf@nvidia.com> <a5aeaec7-d4fc-47e1-b618-e7c768dada54@gmail.com>
In-Reply-To: <a5aeaec7-d4fc-47e1-b618-e7c768dada54@gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Mon, 21 Jul 2025 09:59:04 +0530
X-Gm-Features: Ac12FXybQ9UNRuURZrL6_CEl2LE2ND9hWugy3zzuXgS6UBycLXdUHg1rF3vBP7c
Message-ID: <CAFwiDX9K8T4uDRCmp3R+TqBaKO_jtXwcaeFYdpg-9C5MVJAo4Q@mail.gmail.com>
Subject: Re: [PATCH -next 0/6] Patches for v6.17
To: Akira Yokosawa <akiyks@gmail.com>
Cc: joelagnelf@nvidia.com, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 20, 2025 at 10:01=E2=80=AFAM Akira Yokosawa <akiyks@gmail.com> =
wrote:

...

> There seems to be a couple of issues in the S-O-B chains of commits liste=
d
> below (in rcu/next):
>
>  * dcf1668449c9 ("rcu: Document GP init vs hotplug-scan ordering requirem=
ents")
>  * bb1c373934db ("rcu: Document concurrent quiescent state reporting for =
offline CPUs")
>
> They have a "Co-developed-by:" tag without a corresponding "Signed-off-by=
:"
> tag [1].
>
> Or, if the contribution is too minor to have a "Signed-off-by:",
> then a "Suggested-by:" tag with a "Link:" to the relevant message should
> suffice.
>
> I have no idea which approach suits better in each commit above.
>
> [1]: Documentation/process/submitting-patches.rst
>      section "When to use Acked-by:, Cc:, and Co-developed-by:"
>

Thanks for reviewing this! I will fix the tags.


> Quoting relevant paragraph:
>
>   Co-developed-by: states that the patch was co-created by multiple devel=
opers;
>   it is used to give attribution to co-authors (in addition to the author
>   attributed by the From: tag) when several people work on a single patch=
.  Since
>   Co-developed-by: denotes authorship, every Co-developed-by: must be imm=
ediately
>   followed by a Signed-off-by: of the associated co-author.  Standard sig=
n-off
>   procedure applies, i.e. the ordering of Signed-off-by: tags should refl=
ect the
>   chronological history of the patch insofar as possible, regardless of w=
hether
>   the author is attributed via From: or Co-developed-by:.  Notably, the l=
ast
>   Signed-off-by: must always be that of the developer submitting the patc=
h.
>
> Side note:
>   scripts/checkpatch.pl would have complained about those missing
>   Signed-off-by: tags.
>
> >
> >  .../Data-Structures/Data-Structures.rst       |  32 +++++
> >  .../RCU/Design/Requirements/Requirements.rst  | 128 ++++++++++++++++++
>
> I'm seeing sub-optimal uses of reST markups in Requirements.rst from kern=
el
> documentation stand point.
>
> I'm going to submit a patch or two to improve them, but I can't promise w=
hen.
> They will likely be only cosmetic cleanups and I'm OK with it upstreamed =
as
> it is.
>

Thanks!


- Neeraj
