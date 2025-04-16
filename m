Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81897229B2A;
	Wed, 16 Apr 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775735; cv=none; b=qgnRkBV1ajtso4d6p+oQDlnm0eixw7DDynRuLjPjIKfe/ED6aI79x5leGn3//TL12VoG5+7xKoZKfK7C/cnuQfgwthhU5Ab5+xOJLzNzWW36J6ce869hM1bW83Hc1SV3H7LLDD0LLkeu8tHB1d6V62kOQLLmjTOiMd9eSLGmxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775735; c=relaxed/simple;
	bh=nNzjl5SNbF7onxqfGPdJL2S1ZRBegf5wL5c+qn9ZhJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXPgM9WWNRC/6H3778k2xKtaLqU05gJ9zSi5lLDrfibUfQUiOX9Wm83MSYGbQlx+vwq/rSbNeUpNMgUa6MMIp15B1M/5W1BokeGD6sa+/XsTjh4HCq2a1UV99CnRt04kyDHNe/cBQKnvg6pQnN4sbnk8D4SFeiE3zSFsjuldv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLVawUuE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLVawUuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B8FC4CEE2;
	Wed, 16 Apr 2025 03:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744775735;
	bh=nNzjl5SNbF7onxqfGPdJL2S1ZRBegf5wL5c+qn9ZhJg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nLVawUuEqTy+WfTd4vRnoa5egffHzLC0WVP4tKcsWyBwyIGGx+6P0QNRiEr7KlHFX
	 djvnrtewIpXO4jAiHP4IKQ34ggcKKLhgfNkSI/aAcoZ7BDOEnTzev7qT7gWlOs9VF8
	 ROlWBZ3I0eax2B9sZdRgvlUXP5+wcBsDhYTPz2jE/GDWdPr1pNIh+LHCA9HNgPVfS4
	 FJzrgnhOEr8dbM3BgSgoug0YJzTsKRXfVrMVHaXLiUYFyWrOs7sPQqqctbpVSKU77k
	 Vor+PkqM22ZkjXaqPgFTsUrNvwIm+jc95aZDbdHl9o/114q4VRB9iLtKfAqVTpR3vv
	 UQTS5zPOAeOTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9CA40CE06FE; Tue, 15 Apr 2025 20:55:34 -0700 (PDT)
Date: Tue, 15 Apr 2025 20:55:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 05/12] rcutorture: Add tests for SRCU up/down reader
 primitives
Message-ID: <d4bbae19-065c-47bd-9493-366aa98d4e6f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-5-paulmck@kernel.org>
 <d40885a0-b0e3-4f13-a2b3-41ee2defbde0@nvidia.com>
 <37400faf-8d31-44ef-b9d1-6c91fa19b4f3@paulmck-laptop>
 <1d60ee60-2924-433d-a9b7-726f82f0e546@paulmck-laptop>
 <553c33d8-2b51-4772-8aef-97b0163bc78e@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <553c33d8-2b51-4772-8aef-97b0163bc78e@nvidia.com>

On Tue, Apr 15, 2025 at 09:14:36PM -0400, Joel Fernandes wrote:
> 
> 
> On 4/15/2025 5:15 PM, Paul E. McKenney wrote:
> > On Tue, Apr 15, 2025 at 10:59:36AM -0700, Paul E. McKenney wrote:
> >> On Tue, Apr 15, 2025 at 01:16:15PM -0400, Joel Fernandes wrote:
> >>>
> >>>
> >>> On 3/31/2025 5:03 PM, Paul E. McKenney wrote:
> >>>> This commit adds a new rcutorture.n_up_down kernel boot parameter
> >>>> that specifies the number of outstanding SRCU up/down readers, which
> >>>> begin in kthread context and end in an hrtimer handler.  There is a new
> >>>> kthread ("rcu_torture_updown") that scans an per-reader array looking
> >>>> for elements whose readers have ended.  This kthread sleeps between one
> >>>> and two milliseconds between consecutive scans.
> >>>>
> >>>> [ paulmck: Apply kernel test robot feedback. ]
> >>>> [ paulmck: Apply Z qiang feedback. ]
> >>>>
> >>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>>
> >>> For completeness, posting our discussion for the archives, an issue exists in
> >>> this patch causing the following errors on an ARM64 machine with 288 CPUs:
> >>>
> >>> When running SRCU-P test, we intermittently see:
> >>>
> >>> [ 9500.806108] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
> >>> ->state 0x2 cpu 4
> >>> [ 9515.833356] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
> >>> ->state 0x2 cpu 4
> >>>
> >>> It bisected to just this patch.
> >>
> >> Looks like your getting rcutorture running on ARM was well timed!
> 
> Yes! Glad I could help.
> 
> > And could you please send along your dmesg and .config files?
> 
> Sure, attached both for one of the failed runs.

Thank you!  That did answer at least one of my questions.  It also showed
the need for the diff below.  :-/

As in kvm.sh and friends might well be missing failures in your runs.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index aad51e7c0183d..991fb11306eb6 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -10,7 +10,7 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
-grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Call trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index b07c11cf6929d..21e6ba3615f6a 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -148,7 +148,7 @@ then
 			summary="$summary  KCSAN: $n_kcsan"
 		fi
 	fi
-	n_calltrace=`grep -c 'Call Trace:' $file`
+	n_calltrace=`grep -Ec 'Call Trace:|Call trace:' $file`
 	if test "$n_calltrace" -ne 0
 	then
 		summary="$summary  Call Traces: $n_calltrace"
