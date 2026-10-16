Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9954DACE
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172507; cv=none; b=kovstOEjjTxRspzmxaWCKkpnQjdRX3Gu7dUxYc4aPZ4CAziDAaAIRpWmNnLoQuMPTRw1EbCuFPitXzVSSm6FcxV9XH/Zknm0KDNjjqjA6a4lOW287jtRn4JQ+r7CQPj++6p7g+jcRcsKA11x0eHjGfvbSrWdpWkwtiadFLvBg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172507; c=relaxed/simple;
	bh=3ArrR3ssE5EdoCZnb27zZj+71DbXxmczVzpLhgu1ls0=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=LrKv93rgTHNDOlMz3kpetkS0pHk+w9ytTkBzn7vi1iCcDwY5JurpFycAs3DqPRBfzuQmF3+64PvBCYxKn4hH2LuaRKJBwpHvKJC1vKF3Z1B3+DjGcIdagdOigzc8wuI0gJyOUL956KIZOVKrfcqc2Bh/idAFy2M4h4ddUXlq4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=CsRT9Tsl; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=xD+6eykA; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="CsRT9Tsl";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="xD+6eykA"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792172499; bh=2yw9LtDL+UyYQiO3ffkAfX1
	tHOB+RXVNy+Ve3LB7tbU=; b=CsRT9TslftsNwheoSlRIAq4dLc3adsUCV2TBrCyMaBw8GUL5bK
	jFbbYdmtFcllamf2JYH17/NgfQOcj1ZoSAXhihRptXrKYX1GxJmv+vBuAUthabGZwLdADR61YaE
	LN4fd9BouPnTLUPsmTNZWDgNou1keTYR4C/OK0rlOn34DRqUcFRBCe5opsB5XkPsXLc3cz/FXSY
	Xafm4zwJPAR2K6Br2RAwiNMGHvn0HqRZ0ZDN6wfIj85WcmY7WD4avZ606SC8usxcVb/8+NayI6+
	huP1Id/0SFJelPqBYKQPa8A2kH+EfZuMB5qJog3rjp+1443RVNzXU8qlWDDL/66WggQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792172499; bh=2yw9LtDL+UyYQiO3ffkAfX1
	tHOB+RXVNy+Ve3LB7tbU=; b=xD+6eykAm3N20mcYWbCWlUHJyycRmN/R/Tvo+Au0eOVwop50AT
	oFYvlaUMAd3cIbtDfC9YPmGcgnyiW6qJcTAw==;
Date: Fri, 16 Oct 2026 18:41:40 +0100
From: Bradley Morgan <brads@mainlining.org>
To: puranjay@kernel.org
CC: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, paulmck@kernel.org, rcu@vger.kernel.org,
 rostedt@goodmis.org
Subject: Re: [PATCH] rcutorture: Ignore KBUILD_OUTPUT in kvm.sh
In-Reply-To: <20261016102657.2347381-1-puranjay@kernel.org>
Message-ID: <EA49C261-FD53-4403-9EAF-0C2EF111099B@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 October 2026 11:26:56 BST, Puranjay Mohan <puranjay@kernel.org>
wrote:
>kvm.sh builds the kernel in the source tree, and kvm-build.sh and
>configinit.sh expect .config and the build products to land there.
>With KBUILD_OUTPUT set in the environment, make instead writes them to
>that directory and fails with "The source tree is not clean" or, worse,
>clobbers an unrelated build.  Unset it so kvm.sh works from such shells.

I also have seem to faced this.

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Tested-by: Bradley Morgan <brads@mainlining.org> # Power10


>
>Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>---
> tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
>index 86dd5c131d226..ee8266156254b 100755
>--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
>+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
>@@ -22,6 +22,10 @@ cd `dirname $scriptname`/../../../../../
> # This script knows only English.
> LANG=en_US.UTF-8; export LANG
> 
>+# The kernel is built in-tree below, so an out-of-tree KBUILD_OUTPUT in the
>+# environment would send .config and the build products somewhere else.
>+unset KBUILD_OUTPUT
>+
> dur=$((30*60))
> dryrun=""
> RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
