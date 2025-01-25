Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A88D5FDA7;
	Sat, 25 Jan 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737819321; cv=none; b=FmXQqNNGWANeazUzv+QTQb2R6DxbiWLzPWOQVtPpQDdIZn/wgBUX+tJwM30pgWWA5INsEW4i1FOGtZkazS0wzazxCreJQlAie0LpAqZLFLaX+kdkUAM5JjZdhR/8qYqPw5mBKLZkLe95pYcxp7Hw1T0P7RNXFcBsZ4PgV1UvoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737819321; c=relaxed/simple;
	bh=nwTkJvR+z7FZpQlRVuqQstfX9TUdBdMalekI9zGiJZ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hl7rqbmZKO/E0P83dp8KZcQ5MJJYWtv5/q3924VIyDUJs/pAApTw033p0LJnc/U+go/8ydcKC8kPvMv6UAZ6zhrsscmgHYq7D+C1Bmah9yNV0xCOMgaIBBS2Kv8YReIX7J0HCQCH+TGVshhlKmTpuUvnA2AohIVzCXjW2bzIlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0AD3892009C; Sat, 25 Jan 2025 16:35:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 032FD92009B;
	Sat, 25 Jan 2025 15:35:08 +0000 (GMT)
Date: Sat, 25 Jan 2025 15:35:08 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <Z5NxuIFsMUvqWUtC@minute>
Message-ID: <alpine.DEB.2.21.2501241058520.27203@angie.orcam.me.uk>
References: <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com> <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com> <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com> <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com> <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute> <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk> <Z5NxuIFsMUvqWUtC@minute>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jan 2025, Ivan Kokshaysky wrote:

> > > > Indeed, SP_OFF in entry.S is the main suspect at the moment.
> > > 
> > > In fact, it's the odd number of longs (29) in struct pt_regs that makes
> > > the stack misaligned by 8 bytes. The patch below works for me - no more
> > > oopses in rcu-torture test.
> > > 
> > > Unless I'm missing something, this change shouldn't have any ill effects.
> > 
> >  Umm, this is a part of UAPI, and the change in alignment changes the ABI 
> > (think padding where `struct pt_regs' has been embedded into another 
> > structure), so AFAICT it is a no-no.
> 
> Well, the only userspace applications I can think of that need kernel
> stack layout are debuggers, but at least alpha gdb doesn't use this header.
> Doesn't matter, though - padding *after* PAL-saved registers is wrong
> thing to do. I think it's the reason for oopses that Magnus reported
> today.
> 
> A "long" padding memder of pt_regs placed *before* PAL-saved registers
> would be a proper fix for kernel, but it most likely would break gdb...
> 
> >  But the only place I could quickly find this should matter for is this:
> > 
> > 	/* ... and find our stack ... */
> > 	lda	$30,0x4000 - SIZEOF_PT_REGS($8)
> > 
> > which should be straightforward to fix:
> > 
> > 	lda	$30,0x4000 - ((SIZEOF_PT_REGS + 15) & ~15)($8)
> > 
> > or suchlike.  Have I missed anything?
> 
> That's the first thing I thought of too, but no, it's just a kernel
> entry point after the bootloader. The stack pointer of kernel threads
> is assigned in alpha/kernel/process.c. Particularly, these macros
> in ptrace.h (non-uapi) are interesting:
> 
> #define task_pt_regs(task) \
>   ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)
> 
> #define current_pt_regs() \
>   ((struct pt_regs *) ((char *)current_thread_info() + 2*PAGE_SIZE) - 1)
> 
> I'll try to play with alignment here, but it will take some time.

 So after a crash course in PALcode stack frames I have come up with the 
following WIP patch that works for me.  If things go well, I'll clean it 
up a little and turn into a proper patch submission.  Not that I think I 
can make the end result particularly pretty, there's no easy way AFAICT.

 NB with some instrumentation here's what gets reported for stack without:

start_kernel: SP: fffffc0000dcfe98
do_entInt: SP: fffffc0000dcfc30
copy_thread: SP: fffffc0000dcfc98, regs: fffffc0000dcff18, childregs: fffffc0001837f18, childstack: fffffc0001837ed8
do_page_fault: SP: fffffc0001837bc8
sys_exit_group: SP: fffffc0002917ef8
do_entUnaUser: SP: fffffc0001f33e70
do_entArith: SP: fffffc0001f33ee8
do_entIF: SP: fffffc000184bee8

and with the patch:

start_kernel: SP: fffffc0000dcfe90
do_entInt: SP: fffffc0000dcfc20
copy_thread: SP: fffffc0000dcfc90, regs: fffffc0000dcff18, childregs: fffffc000183bf18, childstack: fffffc000183bed0
do_page_fault: SP: fffffc000183bbc0
sys_exit_group: SP: fffffc00028d3ef0
do_entUnaUser: SP: fffffc000292fe70
do_entArith: SP: fffffc0001d7fee0
do_entIF: SP: fffffc0002827ee0

for the relevant situations (except for `entDbg', but that's analogous and 
largely unused anyway).

 Can you guys please give it a try?

  Maciej
---
 arch/alpha/kernel/entry.S   |  262 +++++++++++++++++++++++++-------------------
 arch/alpha/kernel/head.S    |    4 
 arch/alpha/kernel/process.c |   12 +-
 3 files changed, 160 insertions(+), 118 deletions(-)

Index: linux-melmac/arch/alpha/kernel/entry.S
===================================================================
--- linux-melmac.orig/arch/alpha/kernel/entry.S
+++ linux-melmac/arch/alpha/kernel/entry.S
@@ -16,7 +16,7 @@
 	.cfi_sections	.debug_frame
 
 /* Stack offsets.  */
-#define SP_OFF			184
+#define SP_OFF			192
 #define SWITCH_STACK_SIZE	64
 
 .macro	CFI_START_OSF_FRAME	func
@@ -52,80 +52,80 @@
 .macro	SAVE_ALL
 	subq	$sp, SP_OFF, $sp
 	.cfi_adjust_cfa_offset	SP_OFF
-	stq	$0, 0($sp)
-	stq	$1, 8($sp)
-	stq	$2, 16($sp)
-	stq	$3, 24($sp)
-	stq	$4, 32($sp)
-	stq	$28, 144($sp)
-	.cfi_rel_offset	$0, 0
-	.cfi_rel_offset $1, 8
-	.cfi_rel_offset	$2, 16
-	.cfi_rel_offset	$3, 24
-	.cfi_rel_offset	$4, 32
-	.cfi_rel_offset	$28, 144
+	stq	$0, 8($sp)
+	stq	$1, 16($sp)
+	stq	$2, 24($sp)
+	stq	$3, 32($sp)
+	stq	$4, 40($sp)
+	stq	$28, 152($sp)
+	.cfi_rel_offset	$0, 8
+	.cfi_rel_offset $1, 16
+	.cfi_rel_offset	$2, 24
+	.cfi_rel_offset	$3, 32
+	.cfi_rel_offset	$4, 40
+	.cfi_rel_offset	$28, 152
 	lda	$2, alpha_mv
-	stq	$5, 40($sp)
-	stq	$6, 48($sp)
-	stq	$7, 56($sp)
-	stq	$8, 64($sp)
-	stq	$19, 72($sp)
-	stq	$20, 80($sp)
-	stq	$21, 88($sp)
+	stq	$5, 48($sp)
+	stq	$6, 56($sp)
+	stq	$7, 64($sp)
+	stq	$8, 72($sp)
+	stq	$19, 80($sp)
+	stq	$20, 88($sp)
+	stq	$21, 96($sp)
 	ldq	$2, HAE_CACHE($2)
-	stq	$22, 96($sp)
-	stq	$23, 104($sp)
-	stq	$24, 112($sp)
-	stq	$25, 120($sp)
-	stq	$26, 128($sp)
-	stq	$27, 136($sp)
-	stq	$2, 152($sp)
-	stq	$16, 160($sp)
-	stq	$17, 168($sp)
-	stq	$18, 176($sp)
-	.cfi_rel_offset	$5, 40
-	.cfi_rel_offset	$6, 48
-	.cfi_rel_offset	$7, 56
-	.cfi_rel_offset	$8, 64
-	.cfi_rel_offset $19, 72
-	.cfi_rel_offset	$20, 80
-	.cfi_rel_offset	$21, 88
-	.cfi_rel_offset $22, 96
-	.cfi_rel_offset	$23, 104
-	.cfi_rel_offset	$24, 112
-	.cfi_rel_offset	$25, 120
-	.cfi_rel_offset	$26, 128
-	.cfi_rel_offset	$27, 136
+	stq	$22, 104($sp)
+	stq	$23, 112($sp)
+	stq	$24, 120($sp)
+	stq	$25, 128($sp)
+	stq	$26, 136($sp)
+	stq	$27, 144($sp)
+	stq	$2, 160($sp)
+	stq	$16, 168($sp)
+	stq	$17, 176($sp)
+	stq	$18, 184($sp)
+	.cfi_rel_offset	$5, 48
+	.cfi_rel_offset	$6, 56
+	.cfi_rel_offset	$7, 64
+	.cfi_rel_offset	$8, 72
+	.cfi_rel_offset $19, 80
+	.cfi_rel_offset	$20, 88
+	.cfi_rel_offset	$21, 96
+	.cfi_rel_offset $22, 104
+	.cfi_rel_offset	$23, 112
+	.cfi_rel_offset	$24, 120
+	.cfi_rel_offset	$25, 128
+	.cfi_rel_offset	$26, 136
+	.cfi_rel_offset	$27, 144
 .endm
 
 .macro	RESTORE_ALL
 	lda	$19, alpha_mv
-	ldq	$0, 0($sp)
-	ldq	$1, 8($sp)
-	ldq	$2, 16($sp)
-	ldq	$3, 24($sp)
-	ldq	$21, 152($sp)
+	ldq	$0, 8($sp)
+	ldq	$1, 16($sp)
+	ldq	$2, 24($sp)
+	ldq	$3, 32($sp)
+	ldq	$21, 160($sp)
 	ldq	$20, HAE_CACHE($19)
-	ldq	$4, 32($sp)
-	ldq	$5, 40($sp)
-	ldq	$6, 48($sp)
-	ldq	$7, 56($sp)
+	ldq	$4, 40($sp)
+	ldq	$5, 48($sp)
+	ldq	$6, 56($sp)
+	ldq	$7, 64($sp)
 	subq	$20, $21, $20
-	ldq	$8, 64($sp)
+	ldq	$8, 72($sp)
 	beq	$20, 99f
 	ldq	$20, HAE_REG($19)
 	stq	$21, HAE_CACHE($19)
 	stq	$21, 0($20)
-99:	ldq	$19, 72($sp)
-	ldq	$20, 80($sp)
-	ldq	$21, 88($sp)
-	ldq	$22, 96($sp)
-	ldq	$23, 104($sp)
-	ldq	$24, 112($sp)
-	ldq	$25, 120($sp)
-	ldq	$26, 128($sp)
-	ldq	$27, 136($sp)
-	ldq	$28, 144($sp)
+99:	ldq	$19, 80($sp)
+	ldq	$20, 88($sp)
+	ldq	$21, 96($sp)
+	ldq	$22, 104($sp)
+	ldq	$23, 112($sp)
+	ldq	$24, 120($sp)
+	ldq	$25, 128($sp)
+	ldq	$26, 136($sp)
+	ldq	$27, 144($sp)
+	ldq	$28, 152($sp)
 	addq	$sp, SP_OFF, $sp
 	.cfi_restore	$0
 	.cfi_restore	$1
@@ -152,6 +152,26 @@
 .macro	DO_SWITCH_STACK
 	bsr	$1, do_switch_stack
 	.cfi_adjust_cfa_offset	SWITCH_STACK_SIZE
+	.cfi_rel_offset	$9, 8
+	.cfi_rel_offset	$10, 16
+	.cfi_rel_offset	$11, 24
+	.cfi_rel_offset	$12, 32
+	.cfi_rel_offset	$13, 40
+	.cfi_rel_offset	$14, 48
+	.cfi_rel_offset	$15, 56
+.endm
+
+.macro	DO_SWITCH_STACK_0
+	lda	$sp, -SWITCH_STACK_SIZE($sp)
+	.cfi_adjust_cfa_offset	-SWITCH_STACK_SIZE
+	stq	$9, 0($sp)
+	stq	$10, 8($sp)
+	stq	$11, 16($sp)
+	stq	$12, 24($sp)
+	stq	$13, 32($sp)
+	stq	$14, 40($sp)
+	stq	$15, 48($sp)
+	stq	$26, 56($sp)
 	.cfi_rel_offset	$9, 0
 	.cfi_rel_offset	$10, 8
 	.cfi_rel_offset	$11, 16
@@ -173,6 +193,26 @@
 	.cfi_adjust_cfa_offset	-SWITCH_STACK_SIZE
 .endm
 
+.macro	UNDO_SWITCH_STACK_0
+	ldq	$9, 0($sp)
+	ldq	$10, 8($sp)
+	ldq	$11, 16($sp)
+	ldq	$12, 24($sp)
+	ldq	$13, 32($sp)
+	ldq	$14, 40($sp)
+	ldq	$15, 48($sp)
+	ldq	$26, 56($sp)
+	.cfi_restore	$9
+	.cfi_restore	$10
+	.cfi_restore	$11
+	.cfi_restore	$12
+	.cfi_restore	$13
+	.cfi_restore	$14
+	.cfi_restore	$15
+	lda	$sp, SWITCH_STACK_SIZE($sp)
+	.cfi_adjust_cfa_offset	SWITCH_STACK_SIZE
+.endm
+
 /*
  * Non-syscall kernel entry points.
  */
@@ -182,7 +222,7 @@ CFI_START_OSF_FRAME entInt
 	lda	$8, 0x3fff
 	lda	$26, ret_from_sys_call
 	bic	$sp, $8, $8
-	mov	$sp, $19
+	addq	$sp, 8, $19
 	jsr	$31, do_entInt
 CFI_END_OSF_FRAME entInt
 
@@ -191,15 +231,15 @@ CFI_START_OSF_FRAME entArith
 	lda	$8, 0x3fff
 	lda	$26, ret_from_sys_call
 	bic	$sp, $8, $8
-	mov	$sp, $18
+	addq	$sp, 8, $18
 	jsr	$31, do_entArith
 CFI_END_OSF_FRAME entArith
 
 CFI_START_OSF_FRAME entMM
 	SAVE_ALL
 /* save $9 - $15 so the inline exception code can manipulate them.  */
-	subq	$sp, 56, $sp
-	.cfi_adjust_cfa_offset	56
+	subq	$sp, 48, $sp
+	.cfi_adjust_cfa_offset	48
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -227,7 +267,7 @@ CFI_START_OSF_FRAME entMM
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	addq	$sp, 56, $sp
+	addq	$sp, 48, $sp
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -235,7 +275,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-48
 /* finish up the syscall as normal.  */
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entMM
@@ -245,7 +285,7 @@ CFI_START_OSF_FRAME entIF
 	lda	$8, 0x3fff
 	lda	$26, ret_from_sys_call
 	bic	$sp, $8, $8
-	mov	$sp, $17
+	addq	$sp, 8, $17
 	jsr	$31, do_entIF
 CFI_END_OSF_FRAME entIF
 
@@ -382,8 +422,8 @@ CFI_START_OSF_FRAME entUna
 	.cfi_restore	$0
 	.cfi_adjust_cfa_offset	-256
 	SAVE_ALL		/* setup normal kernel stack */
-	lda	$sp, -56($sp)
-	.cfi_adjust_cfa_offset	56
+	lda	$sp, -48($sp)
+	.cfi_adjust_cfa_offset	48
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -409,7 +449,7 @@ CFI_START_OSF_FRAME entUna
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	lda	$sp, 56($sp)
+	lda	$sp, 48($sp)
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -417,7 +457,7 @@ CFI_START_OSF_FRAME entUna
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-48
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entUna
 
@@ -426,7 +466,7 @@ CFI_START_OSF_FRAME entDbg
 	lda	$8, 0x3fff
 	lda	$26, ret_from_sys_call
 	bic	$sp, $8, $8
-	mov	$sp, $16
+	addq	$sp, 8, $16
 	jsr	$31, do_entDbg
 CFI_END_OSF_FRAME entDbg
 
@@ -478,8 +518,8 @@ CFI_END_OSF_FRAME entDbg
 	ldgp	$gp, 0($26)
 	blt	$0, $syscall_error	/* the call failed */
 $ret_success:
-	stq	$0, 0($sp)
-	stq	$31, 72($sp)		/* a3=0 => no error */
+	stq	$0, 8($sp)
+	stq	$31, 80($sp)		/* a3=0 => no error */
 
 	.align	4
 	.globl	ret_from_sys_call
@@ -520,15 +560,15 @@ CFI_END_OSF_FRAME entDbg
 	 * frame to indicate that a negative return value wasn't an
 	 * error number..
 	 */
-	ldq	$18, 0($sp)	/* old syscall nr (zero if success) */
+	ldq	$18, 8($sp)	/* old syscall nr (zero if success) */
 	beq	$18, $ret_success
 
-	ldq	$19, 72($sp)	/* .. and this a3 */
+	ldq	$19, 80($sp)	/* .. and this a3 */
 	subq	$31, $0, $0	/* with error in v0 */
 	addq	$31, 1, $1	/* set a3 for errno return */
-	stq	$0, 0($sp)
+	stq	$0, 8($sp)
 	mov	$31, $26	/* tell "ret_from_sys_call" we can restart */
-	stq	$1, 72($sp)	/* a3 for return */
+	stq	$1, 80($sp)	/* a3 for return */
 	br	ret_from_sys_call
 
 /*
@@ -559,7 +599,7 @@ CFI_END_OSF_FRAME entDbg
 	br	ret_to_user
 
 $work_notifysig:
-	mov	$sp, $16
+	addq	$sp, 8, $16
 	DO_SWITCH_STACK
 	jsr	$26, do_work_pending
 	UNDO_SWITCH_STACK
@@ -589,9 +629,9 @@ CFI_END_OSF_FRAME entDbg
 	ldq	$16, SP_OFF+24($sp)
 	ldq	$17, SP_OFF+32($sp)
 	ldq	$18, SP_OFF+40($sp)
-	ldq	$19, 72($sp)
-	ldq	$20, 80($sp)
-	ldq	$21, 88($sp)
+	ldq	$19, 80($sp)
+	ldq	$20, 88($sp)
+	ldq	$21, 96($sp)
 
 	/* get the system call pointer.. */
 	lda	$1, NR_syscalls($31)
@@ -608,8 +648,8 @@ CFI_END_OSF_FRAME entDbg
 	/* check return.. */
 	blt	$0, $strace_error	/* the call failed */
 $strace_success:
-	stq	$31, 72($sp)		/* a3=0 => no error */
-	stq	$0, 0($sp)		/* save return value */
+	stq	$31, 80($sp)		/* a3=0 => no error */
+	stq	$0, 8($sp)		/* save return value */
 
 	DO_SWITCH_STACK
 	jsr	$26, syscall_trace_leave
@@ -618,14 +658,14 @@ CFI_END_OSF_FRAME entDbg
 
 	.align	3
 $strace_error:
-	ldq	$18, 0($sp)	/* old syscall nr (zero if success) */
+	ldq	$18, 8($sp)	/* old syscall nr (zero if success) */
 	beq	$18, $strace_success
-	ldq	$19, 72($sp)	/* .. and this a3 */
+	ldq	$19, 80($sp)	/* .. and this a3 */
 
 	subq	$31, $0, $0	/* with error in v0 */
 	addq	$31, 1, $1	/* set a3 for errno return */
-	stq	$0, 0($sp)
-	stq	$1, 72($sp)	/* a3 for return */
+	stq	$0, 8($sp)
+	stq	$1, 80($sp)	/* a3 for return */
 
 	DO_SWITCH_STACK
 	mov	$18, $9		/* save old syscall number */
@@ -652,14 +692,14 @@ CFI_END_OSF_FRAME entSys
 do_switch_stack:
 	lda	$sp, -SWITCH_STACK_SIZE($sp)
 	.cfi_adjust_cfa_offset	SWITCH_STACK_SIZE
-	stq	$9, 0($sp)
-	stq	$10, 8($sp)
-	stq	$11, 16($sp)
-	stq	$12, 24($sp)
-	stq	$13, 32($sp)
-	stq	$14, 40($sp)
-	stq	$15, 48($sp)
-	stq	$26, 56($sp)
+	stq	$9, 8($sp)
+	stq	$10, 16($sp)
+	stq	$11, 24($sp)
+	stq	$12, 32($sp)
+	stq	$13, 40($sp)
+	stq	$14, 48($sp)
+	stq	$15, 56($sp)
+	stq	$26, 64($sp)
 	ret	$31, ($1), 1
 	.cfi_endproc
 	.size	do_switch_stack, .-do_switch_stack
@@ -670,14 +710,14 @@ CFI_END_OSF_FRAME entSys
 	.cfi_def_cfa $sp, 0
 	.cfi_register 64, $1
 undo_switch_stack:
-	ldq	$9, 0($sp)
-	ldq	$10, 8($sp)
-	ldq	$11, 16($sp)
-	ldq	$12, 24($sp)
-	ldq	$13, 32($sp)
-	ldq	$14, 40($sp)
-	ldq	$15, 48($sp)
-	ldq	$26, 56($sp)
+	ldq	$9, 8($sp)
+	ldq	$10, 16($sp)
+	ldq	$11, 24($sp)
+	ldq	$12, 32($sp)
+	ldq	$13, 40($sp)
+	ldq	$14, 48($sp)
+	ldq	$15, 56($sp)
+	ldq	$26, 64($sp)
 	lda	$sp, SWITCH_STACK_SIZE($sp)
 	ret	$31, ($1), 1
 	.cfi_endproc
@@ -733,7 +773,7 @@ CFI_END_OSF_FRAME entSys
 	.type	alpha_switch_to, @function
 	.cfi_startproc
 alpha_switch_to:
-	DO_SWITCH_STACK
+	DO_SWITCH_STACK_0
 	ldl	$1, TI_STATUS($8)
 	and	$1, TS_RESTORE_FP, $3
 	bne	$3, 1f
@@ -745,7 +785,7 @@ CFI_END_OSF_FRAME entSys
 1:
 	call_pal PAL_swpctx
 	lda	$8, 0x3fff
-	UNDO_SWITCH_STACK
+	UNDO_SWITCH_STACK_0
 	bic	$sp, $8, $8
 	mov	$17, $0
 	ret
@@ -802,7 +842,7 @@ CFI_END_OSF_FRAME entSys
 	bsr	$26, __save_fpu
 1:
 	jsr	$26, sys_\name
-	ldq	$26, 56($sp)
+	ldq	$26, 64($sp)
 	lda	$sp, SWITCH_STACK_SIZE($sp)
 	ret
 .end	alpha_\name
@@ -847,6 +887,6 @@ sigreturn_like rt_sigreturn
 	  */
 	lda	$0, -ENOSYS
 	unop
-	stq	$0, 0($sp)
+	stq	$0, 8($sp)
 	ret
 .end alpha_syscall_zero
Index: linux-melmac/arch/alpha/kernel/head.S
===================================================================
--- linux-melmac.orig/arch/alpha/kernel/head.S
+++ linux-melmac/arch/alpha/kernel/head.S
@@ -25,8 +25,8 @@ __HEAD
 1:	ldgp	$29,0($27)
 	/* We need to get current_task_info loaded up...  */
 	lda	$8,init_thread_union
-	/* ... and find our stack ... */
-	lda	$30,0x4000 - SIZEOF_PT_REGS($8)
+	/* ... and find our stack, ensuring 16-byte alignment ... */
+	lda	$30,0x4000 - (SIZEOF_PT_REGS + 8)($8)
 	/* ... and then we can start the kernel.  */
 	jsr	$26,start_kernel
 	call_pal PAL_halt
Index: linux-melmac/arch/alpha/kernel/process.c
===================================================================
--- linux-melmac.orig/arch/alpha/kernel/process.c
+++ linux-melmac/arch/alpha/kernel/process.c
@@ -240,7 +240,8 @@ int copy_thread(struct task_struct *p, c
 	struct pt_regs *regs = current_pt_regs();
 	struct switch_stack *childstack, *stack;
 
-	childstack = ((struct switch_stack *) childregs) - 1;
+	childstack =
+		((struct switch_stack *)((unsigned long *)childregs - 1)) - 1;
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 	childti->status |= TS_SAVED_FP | TS_RESTORE_FP;
@@ -248,7 +249,8 @@ int copy_thread(struct task_struct *p, c
 	if (unlikely(args->fn)) {
 		/* kernel thread */
 		memset(childstack, 0,
-			sizeof(struct switch_stack) + sizeof(struct pt_regs));
+		       (sizeof(struct switch_stack) +
+			sizeof(unsigned long) + sizeof(struct pt_regs)));
 		childstack->r26 = (unsigned long) ret_from_kernel_thread;
 		childstack->r9 = (unsigned long) args->fn;
 		childstack->r10 = (unsigned long) args->fn_arg;
@@ -345,7 +347,7 @@ int elf_core_copy_task_fpregs(struct tas
  * pointer is the 6th saved long on the kernel stack and that the
  * saved return address is the first long in the frame.  This all
  * holds provided the thread blocked through a call to schedule() ($15
- * is the frame pointer in schedule() and $15 is saved at offset 48 by
+ * is the frame pointer in schedule() and $15 is saved at offset 56 by
  * entry.S:do_switch_stack).
  *
  * Under heavy swap load I've seen this lose in an ugly way.  So do
@@ -360,8 +362,8 @@ thread_saved_pc(struct task_struct *t)
 	unsigned long base = (unsigned long)task_stack_page(t);
 	unsigned long fp, sp = task_thread_info(t)->pcb.ksp;
 
-	if (sp > base && sp+6*8 < base + 16*1024) {
-		fp = ((unsigned long*)sp)[6];
+	if (sp > base && sp + 7 * 8 < base + 16 * 1024) {
+		fp = ((unsigned long *)sp)[7];
 		if (fp > sp && fp < base + 16*1024)
 			return *(unsigned long *)fp;
 	}
